require 'test_helper'

class BuyerTest < ActiveSupport::TestCase
 
   def setup
	   	@address = build(:address)
	   	@buyer = Buyer.new(first_name: "Chris", last_name: "Severns", phone_number: "9548120543", email: "severnsc@gmail.com", address: @address, mailing_address: @address)
   end

   test "should be valid" do
     assert @buyer.valid?
   end
end
