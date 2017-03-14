class Lender < ApplicationRecord
	has_many :title_orders
#	validates :name, presence: true
#	validates :phone_number, presence: true
#	validates :email, presence: true
end
