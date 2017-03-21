class AddOrderTypeToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :order_type, :string
  end
end
