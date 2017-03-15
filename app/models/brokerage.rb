class Brokerage < ApplicationRecord
	belongs_to :address
	has_many :agents
	accepts_nested_attributes_for :address
  validate :address_attr

  def address_attr
    errors.add(:base, "Brokerage address must have street") if address.street.blank?
    errors.add(:base, "Brokerage address must have city") if address.city.blank?
    errors.add(:base, "Brokerage address must have state") if address.state.blank?
    errors.add(:base, "Brokerage address must have zip") if address.zip.blank?
  end
end
