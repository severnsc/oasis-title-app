class CreateBuyers < ActiveRecord::Migration[5.0]
  def change
    create_table :buyers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.references :address

      t.timestamps
    end
  end
end
