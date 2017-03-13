class DropBuyersTitleOrders < ActiveRecord::Migration[5.0]
  def change
    drop_table :buyers_title_orders
  end
end
