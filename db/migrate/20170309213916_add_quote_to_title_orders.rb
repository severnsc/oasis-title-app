class AddQuoteToTitleOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :title_orders, :quote, :boolean, default: false
  end
end
