class AddSpuseToBuyers < ActiveRecord::Migration[5.0]
  def change
  	add_reference :buyers, :spouse, index: true
  end
end
