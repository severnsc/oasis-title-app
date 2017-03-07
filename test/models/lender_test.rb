require 'test_helper'

class LenderTest < ActiveSupport::TestCase
  
  def setup
  	@lender = Lender.new(name: "BoA", phone_number: "9541234567", email: "bank@bankofamerica.com")
  end

  test "should be valid" do
  	assert @lender.valid?
  end

  test "should have a name" do
  	@lender.name = "  "
  	assert_not @lender.valid?
  end

  test "should have a phone number" do
  	@lender.phone_number = "  "
  	assert_not @lender.valid?
  end

  test "should have an email" do
  	@lender.email = "  "
  	assert_not @lender.valid?
  end
end
