class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :search_name
      t.string :buyer_name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.references :user

      t.timestamps
    end
  end
end
