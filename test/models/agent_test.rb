require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  
  def setup
  	@brokerage = brokerages(:agency)
  	@agent = Agent.new(brokerage: @brokerage, first_name: "Chris", last_name: "Severns", phone_number: "9548120543", email: "severnsc@gmail.com", license_number: "BK123456")
  end

  test "should be valid" do
  	assert @agent.valid?
  end

  test "should have a brokerage" do
  	@agent.brokerage = nil
  	assert_not @agent.valid?
  end

  test "should have a first name" do
  	@agent.first_name = "  "
  	assert_not @agent.valid?
  end

  test "should have a last name" do
  	@agent.last_name = "  "
  	assert_not @agent.valid?
  end

  test "should have a phone number" do
  	@agent.phone_number = "  "
  	assert_not @agent.valid?
  end

  test "should have an email" do
  	@agent.email = "  "
  	assert_not @agent.valid?
  end

  test "should have a license_number" do
  	@agent.license_number = "  "
  	assert_not @agent.valid?
  end
end
