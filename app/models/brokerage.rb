class Brokerage < ApplicationRecord
	belongs_to :address
	has_many :agents
#	validates :address, presence: true
#	validates :name, presence: true
#	validates :license_number, presence: true
	accepts_nested_attributes_for :address
end
