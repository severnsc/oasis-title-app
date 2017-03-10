class AddUsersToTitleOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :title_orders, :user, index: true
  end
end
