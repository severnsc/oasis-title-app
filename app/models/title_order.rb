class TitleOrder < ApplicationRecord
	attr_accessor :primary_residence, :number_of_buyers, :married
	belongs_to :property, class_name: "Address"
	belongs_to :buyers_agent, class_name: "Agent"
	belongs_to :sellers_agent, class_name: "Agent"
	belongs_to :lender, optional: true
	belongs_to :user
	has_many :buyer_title_orders, dependent: :destroy, inverse_of: :title_order
	has_many :buyers, through: :buyer_title_orders
	validates :property, presence: true
	validates :buyers_agent, presence: true
	validates :sellers_agent, presence: true
	validates :title_type, presence: true
	validates :closing_type, presence: true
	validates :buyers_agent_commission, presence: true
	validates :sellers_agent_commission, presence: true
	validates :survey_requested, presence: true
	accepts_nested_attributes_for :buyer_title_orders
	accepts_nested_attributes_for :property
	accepts_nested_attributes_for :buyers_agent
	accepts_nested_attributes_for :sellers_agent
	accepts_nested_attributes_for :lender
	validate :child_attr

	def child_attr
		errors.add(:base, "Property must have street") if property.street.blank?
		errors.add(:base, "Property must have city") if property.city.blank?
		errors.add(:base, "Property must have state") if property.state.blank?
		errors.add(:base, "Property must have zip") if property.zip.blank?
		errors.add(:base, "Lender must have name") if lender.name.blank?
		errors.add(:base, "Lender must have phone number") if lender.phone_number.blank?
		errors.add(:base, "Lender must have email") if lender.email.blank?
		errors.add(:base, "Buyers agent must have first name") if buyers_agent.first_name.blank?
		errors.add(:base, "Buyers agent must have last name") if buyers_agent.last_name.blank?
		errors.add(:base, "Buyers agent must have phone number") if buyers_agent.phone_number.blank?
		errors.add(:base, "Buyers agent must have email") if buyers_agent.email.blank?
		errors.add(:base, "Buyers agent must have license number") if buyers_agent.license_number.blank?
		errors.add(:base, "Sellers agent must have first name") if sellers_agent.first_name.blank?
		errors.add(:base, "Sellers agent must have last name") if sellers_agent.last_name.blank?
		errors.add(:base, "Sellers agent must have phone number") if sellers_agent.phone_number.blank?
		errors.add(:base, "Sellers agent must have email") if sellers_agent.email.blank?
		errors.add(:base, "Sellers agent must have license number") if sellers_agent.license_number.blank?
	end

	def mail_title_order_admins
		@admins = User.where('title_administrator = ?', true)
		@admins.each do |admin|
			admin.send_title_alert_email(self)
		end
	end

	def check_params(params)
		buyer_title_orders.each_with_index do |bto, i| 
			bto.build_buyer(params['buyer_title_orders_attributes']["#{i}"]['buyer_attributes'])
		end
		if params['primary_residence'] == '1'
			buyer_title_orders.each do |bto|
				bto.buyer.address = property
			end
		else
			buyer_title_orders.each do |bto|
				bto.buyer.address = bto.buyer.mailing_address
			end
		end
		build_buyers_agent(params['buyers_agent_attributes'])
		build_sellers_agent(params['sellers_agent_attributes'])
		marry_buyers if params['married'] == '1'
		quote = false if params['quote'] == '0'
	end

	def self.search(params, current_user)
		if params[:type] == 'quotes'
			if current_user.admin?
				if params[:name_search]
					@title_orders = joins(:buyers).where("buyers.first_name LIKE ? OR buyers.last_name LIKE ?", params[:name_search], params[:name_search])
					@title_orders = @title_orders.where('quote = ?', true)
				else
					@title_orders = where('quote = ?', true)
				end
			else
				if params[:name_search]
					@title_orders = current_user.title_orders.joins(:buyers).where('buyers.first_name LIKE ? OR buyers.last_name LIKE ?', params[:name_search], params[:name_search])
					@title_orders = @title_orders.where('quote = ?', true)
				else
					@title_orders = current_user.title_orders.where('quote = ?', true)
				end
			end
		elsif params[:type] == 'orders'
			if current_user.admin?
				if params[:name_search]
					@title_orders = joins(:buyers).where("buyers.first_name LIKE ? OR buyers.last_name LIKE ?", params[:name_search], params[:name_search])
					@title_orders = @title_orders.where('quote = ?', false)
				else
					@title_orders = where('quote = ?', false)
				end
			else
				if params[:name_search]
					@title_orders = current_user.title_orders.joins(:buyers).where("buyers.first_name LIKE ? OR buyers.last_name LIKE ?", params[:name_search], params[:name_search])
					@title_orders = @title_orders.where('quote = ?', false)
				else
					@title_orders = current_user.title_orders.where('quote = ?', false)
				end
			end
		else
			if params[:name_search]
				if current_user.admin?
					@title_orders = joins(:buyers).where('buyers.first_name LIKE ? OR buyers.last_name LIKE ?', params[:name_search], params[:name_search])
					@title_orders = @title_orders.where('quote = ?', false)
				else
					@title_orders = current_user.title_orders.joins(:buyers).where('buyers.first_name LIKE ? OR buyers.last_name LIKE ?', params[:name_search], params[:name_search])
				end
			else
				current_user.admin? ? @title_orders = where('quote = ?', false) : @title_orders = current_user.title_orders.where('quote = ?', false)
			end
		end
	end

	def lender_attributes=(attributes)
		self.lender = Lender.where(attributes).first_or_create
	end

	def buyers_agent_attributes=(attributes)
		self.buyers_agent = Agent.where("first_name = ? AND last_name = ? AND phone_number = ? AND email = ? AND license_number =?", attributes[:first_name], attributes[:last_name], attributes[:phone_number], attributes[:email], attributes[:license_number]).first_or_create
	end

	def sellers_agent_attributes=(attributes)
		self.sellers_agent = Agent.where("first_name = ? AND last_name = ? AND phone_number = ? AND email = ? AND license_number =?", attributes[:first_name], attributes[:last_name], attributes[:phone_number], attributes[:email], attributes[:license_number]).first_or_create
	end

	def property_attributes=(attributes)
		self.property = Address.where(attributes).first_or_create
	end

	def marry_buyers
		self.buyers.each_with_index {|buyer, i| buyer.spouse = self.buyers[i-1]}
	end
end