require 'test_helper'

class LenderTest < ActiveSupport::TestCase
  
  def setup
  	@lender = Lender.new(name: "BoA", phone_number: "9541234567", email: "bank@bankofamerica.com")
  end

  test "should be valid" do
  	assert @lender.valid?
  end
end
