require 'test_helper'

class BrokerageTest < ActiveSupport::TestCase

	def setup
		@address = addresses(:office)
		@brokerage = Brokerage.new(address: @address, name: "Agency Luxe", license_number: "BK123456")
	end

	test "should be valid" do
		assert @brokerage.valid?
	end

	test "should have an address" do
		@brokerage.address  = nil
		assert_not @brokerage.valid?
	end

	test "should have a name" do
		@brokerage.name = "  "
		assert_not @brokerage.valid?
	end

	test "should have a license number" do
		@brokerage.license_number = "  "
		assert_not @brokerage.valid?
	end
end