class BuyerTitleOrder < ApplicationRecord
  belongs_to :buyer, inverse_of: :buyer_title_orders
  belongs_to :title_order, inverse_of: :buyer_title_orders
  accepts_nested_attributes_for :buyer
  validate :buyer_attrs

  def buyer_attrs
    errors.add(:base, "Buyer must have a first name") if buyer.first_name.blank?
    errors.add(:base, "Buyer must have a last name") if buyer.last_name.blank?
    errors.add(:base, "Buyer must have a phone number") if buyer.phone_number.blank?
    errors.add(:base, "Buyer must have an email address") if buyer.email.blank?
    errors.add(:base, "Buyer mailing address must have street") if buyer.mailing_address.street.blank?
    errors.add(:base, "Buyer mailing address must have city") if buyer.mailing_address.city.blank?
    errors.add(:base, "Buyer mailing address must have state") if buyer.mailing_address.state.blank?
    errors.add(:base, "Buyer mailing address must have zip") if buyer.mailing_address.zip.blank?
  end

  def buyer_attributes=(attributes)
    self.buyer = Buyer.where("first_name = ? AND last_name = ? AND phone_number = ? AND email = ?", attributes[:first_name], attributes[:last_name], attributes[:phone_number], attributes[:email]).first_or_create
  end
end
