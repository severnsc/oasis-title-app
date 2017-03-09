class AddActivatedToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :activated, :boolean, default: false
  	add_column :users, :activated_at, :datetime
  	rename_column :users, :reset_Sent_at, :reset_sent_at
  end
end
