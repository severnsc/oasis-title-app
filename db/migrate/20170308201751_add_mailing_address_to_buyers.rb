class AddMailingAddressToBuyers < ActiveRecord::Migration[5.0]
  def change
  	add_reference :buyers, :mailing_address, index: true
  end
end
