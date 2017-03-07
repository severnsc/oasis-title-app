class CreateBrokerages < ActiveRecord::Migration[5.0]
  def change
    create_table :brokerages do |t|
      t.references :address
      t.string :name
      t.string :license_number

      t.timestamps
    end
  end
end
