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