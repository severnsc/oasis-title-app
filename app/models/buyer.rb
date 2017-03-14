class Buyer < ApplicationRecord
	belongs_to :address, optional: true
	has_many :properties, through: :title_orders
	belongs_to :mailing_address, class_name: "Address", optional: true
	has_many :title_orders, through: :buyer_title_orders
	has_many :buyer_title_orders, inverse_of: :buyer, dependent: :destroy
	belongs_to :spouse, class_name: "Buyer", optional: true
	accepts_nested_attributes_for :mailing_address

	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
