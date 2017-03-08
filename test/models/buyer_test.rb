require 'test_helper'

class BuyerTest < ActiveSupport::TestCase
 
   def setup
	   	@address = addresses(:office)
	   	@buyer = Buyer.new(first_name: "Chris", last_name: "Severns", phone_number: "9548120543", email: "severnsc@gmail.com", address: @address, mailing_address: @address)
   end

   test "should be valid" do
     assert @buyer.valid?
   end

   test "should have a first name" do
     @buyer.first_name = "  "
     assert_not @buyer.valid?
   end

   test "should have a last name" do
   		@buyer.last_name = "  "
   		assert_not @buyer.valid?
   end

   test "should have a phone number" do
   		@buyer.phone_number = "  "
   		assert_not @buyer.valid?
   end

   test "should have an email" do
   		@buyer.email = "  "
   		assert_not @buyer.valid?
   end

   test "should have an address" do
   		@buyer.address = nil
   		assert_not @buyer.valid?
   end
end
