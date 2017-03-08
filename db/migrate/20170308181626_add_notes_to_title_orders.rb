class AddNotesToTitleOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :title_orders, :notes, :text
  end
end
