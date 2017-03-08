class Address < ApplicationRecord
	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true

	def formatted
		"#{self.street}, #{self.city}, #{self.state}, #{self.zip}"
	end
end
