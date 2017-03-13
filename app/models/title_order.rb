class TitleOrder < ApplicationRecord
	#attr_accessor :primary_residence, :number_of_buyers, :married,:notes
	#belongs_to :property, class_name: "Address"
	#belongs_to :buyers_agent, class_name: "Agent"
	#belongs_to :sellers_agent, class_name: "Agent"
	#belongs_to :lender, optional: true
	#belongs_to :user
	has_many :buyer_title_orders, dependent: :destroy, inverse_of: :title_order
	has_many :buyers, through: :buyer_title_orders
	#validates :property, presence: true
#	validates :buyers_agent, presence: true
#	validates :sellers_agent, presence: true
#	validates :title_type, presence: true
#	validates :closing_type, presence: true
#	validates :buyers_agent_commission, presence: true
#	validates :sellers_agent_commission, presence: true
#	validates :survey_requested, presence: true
	accepts_nested_attributes_for :buyer_title_orders
	#accepts_nested_attributes_for :property
#	accepts_nested_attributes_for :buyers_agent
#	accepts_nested_attributes_for :sellers_agent
#	accepts_nested_attributes_for :lender

	#def check_if_params_exist
#		buyers_agent = Agent.find_by_email(self.buyers_agent.email)
#		self.buyers_agent = buyers_agent if buyers_agent
#		sellers_agent = Agent.find_by_email(self.sellers_agent.email)
#		self.sellers_agent = sellers_agent if sellers_agent
#		lender = Lender.find_by_email(self.lender.email)
#		self.lender = lender if lender
#		property = Address.where(['street = ? and city = ? and state = ? and zip = ?', self.property.street, self.property.city, self.property.state, self.property.zip])
#		self.property = property.first unless property.empty?
#		buyers_agent_brokerage = Brokerage.find_by_license_number(self.buyers_agent.brokerage.license_number)
#		self.buyers_agent.brokerage = buyers_agent_brokerage if buyers_agent_brokerage
#		sellers_agent_brokerage = Brokerage.find_by_license_number(self.sellers_agent.brokerage.license_number)
#		self.sellers_agent.brokerage = sellers_agent_brokerage if sellers_agent_brokerage
#	end#

#	def marry_buyers
#		self.buyers.each_with_index {|buyer, i| buyer.spouse = self.buyers[i-1]}
#	end
end