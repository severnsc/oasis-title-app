require 'test_helper'

class BrokerageTest < ActiveSupport::TestCase

	def setup
		@address = build(:address)
		@brokerage = Brokerage.new(address: @address, name: "Agency Luxe", license_number: "BK123456")
	end

	test "should be valid" do
		assert @brokerage.valid?
	end

	test "should have an address" do
		@brokerage.address  = nil
		assert_not @brokerage.valid?
	end
end