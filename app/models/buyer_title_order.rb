class BuyerTitleOrder < ApplicationRecord
  belongs_to :buyer, inverse_of: :buyer_title_orders
  belongs_to :title_order, inverse_of: :buyer_title_orders
  accepts_nested_attributes_for :buyer, reject_if: :buyer_check
  validates :buyer, presence: true
  validates :title_order, presence: true

  private

  def buyer_check(attributes)
    attributes['first_name'].blank? || attributes['last_name'].blank? || attributes['phone_number'].blank? || attributes['email'].blank?
  end
end
