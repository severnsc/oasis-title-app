class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.string :reset_digest
      t.datetime :reset_Sent_at

      t.timestamps
    end
  end
end
