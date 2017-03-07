require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  
  def setup
  	@address = Address.new(street: "21301 Powerline Road", city: "Boca Raton", state: "FL", zip: "33433")
  end

  test "should be valid" do
  	assert @address.valid?
  end

  test "should have street" do
  	@address.street = "  "
  	assert_not @address.valid?
  end

  test "should have city" do
  	@address.city = "  "
  	assert_not @address.valid?
  end

  test "should have state" do
  	@address.state = "  "
  	assert_not @address.valid?
  end

  test "should have zip" do
  	@address.zip = "  "
  	assert_not @address.valid?
  end
end
