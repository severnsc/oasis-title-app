class AddAdminDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_digest, :string
  end
end
