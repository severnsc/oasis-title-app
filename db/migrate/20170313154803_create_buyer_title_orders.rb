class CreateBuyerTitleOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :buyer_title_orders do |t|
      t.references :buyer
      t.references :title_order

      t.timestamps
    end
  end
end
