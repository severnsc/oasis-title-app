class BuyerTitleOrder < ApplicationRecord
  belongs_to :buyer, inverse_of: :buyer_title_orders
  belongs_to :title_order, inverse_of: :buyer_title_orders
  accepts_nested_attributes_for :buyer, reject_if: :buyer_check

  def buyer_attributes=(attributes)
    self.buyer = Buyer.where("first_name = ? AND last_name = ? AND phone_number = ? AND email = ?", attributes[:first_name], attributes[:last_name], attributes[:phone_number], attributes[:email]).first_or_create
  end

  private

  def buyer_check(attributes)
    attrs = ['first_name', 'last_name', 'phone_number', 'email']
    attrs.each do |a|
      self.errors.add(a.to_s, "#{a} cannot be blank") if attributes[a].blank?
    end
  end
end
