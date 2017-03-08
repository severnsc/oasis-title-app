class Buyer < ApplicationRecord
	belongs_to :address
	has_many :properties, through: :title_orders
	belongs_to :mailing_address, class_name: "Address"
	has_and_belongs_to_many :title_orders
	belongs_to :spouse, class_name: "Buyer", optional: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :phone_number, presence: true
	validates :email, presence: true
	validates :address, presence: true
	accepts_nested_attributes_for :mailing_address

	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
