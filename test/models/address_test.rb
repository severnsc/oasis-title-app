require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  
  def setup
  	@address = Address.new(street: "21301 Powerline Road", city: "Boca Raton", state: "FL", zip: "33433")
  end

  test "should be valid" do
  	assert @address.valid?
  end
end
