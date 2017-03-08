class Agent < ApplicationRecord
	belongs_to :brokerage
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :phone_number, presence: true
	validates :email, presence: true
	validates :license_number, presence: true
	validates :brokerage, presence: true
	accepts_nested_attributes_for :brokerage

	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
