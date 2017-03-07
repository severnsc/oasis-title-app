class TitleOrder < ApplicationRecord
	attr_accessor :primary_residence
	belongs_to :property, class_name: "Address"
	belongs_to :buyers_agent, class_name: "Agent"
	belongs_to :sellers_agent, class_name: "Agent"
	belongs_to :lender, optional: true
	has_and_belongs_to_many :buyers
	validates :property, presence: true
	validates :buyers_agent, presence: true
	validates :sellers_agent, presence: true
	validates :title_type, presence: true
	validates :closing_type, presence: true
	validates :buyers_agent_commission, presence: true
	validates :sellers_agent_commission, presence: true
	validates :survey_requested, presence: true
	accepts_nested_attributes_for :property
	accepts_nested_attributes_for :buyers_agent
	accepts_nested_attributes_for :sellers_agent
	accepts_nested_attributes_for :lender
	accepts_nested_attributes_for :buyers
end
