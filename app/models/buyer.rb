class Buyer < ApplicationRecord
	belongs_to :address
	has_many :properties, through: :title_orders
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :phone_number, presence: true
	validates :email, presence: true
	validates :address, presence: true
end
