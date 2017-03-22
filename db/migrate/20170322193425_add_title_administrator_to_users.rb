class AddTitleAdministratorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :title_administrator, :boolean, default: false
  end
end
