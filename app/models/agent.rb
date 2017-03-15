class Agent < ApplicationRecord
	belongs_to :brokerage
  has_many :title_orders
	accepts_nested_attributes_for :brokerage

	def full_name
		"#{self.first_name.capitalize} #{self.last_name.capitalize}"
	end
end
