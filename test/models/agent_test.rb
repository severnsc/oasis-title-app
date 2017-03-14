require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  
  def setup
  	@brokerage = build(:brokerage)
  	@agent = Agent.new(brokerage: @brokerage, first_name: "Chris", last_name: "Severns", phone_number: "9548120543", email: "severnsc@gmail.com", license_number: "BK123456")
  end

  test "should be valid" do
  	assert @agent.valid?
  end
end
