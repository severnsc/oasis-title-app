class BuyerTitleOrder < ApplicationRecord
  belongs_to :buyer, inverse_of: :buyer_title_orders
  belongs_to :title_order, inverse_of: :buyer_title_orders
  accepts_nested_attributes_for :buyer
  validates :buyer, presence: true
  validates :title_order, presence: true

  def check_if_params_exist
    if Buyer.exists?(first_name: self.buyer.first_name, last_name: self.buyer.last_name, phone_number: self.buyer.phone_number, email: self.buyer.email)
      self.buyer = Buyer.where('first_name = ? AND last_name = ? AND phone_number = ? AND email = ?', self.buyer.first_name, self.buyer.last_name, self.buyer.phone_number, self.buyer.email)
    end
  end
end
