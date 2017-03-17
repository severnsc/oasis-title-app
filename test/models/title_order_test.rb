require 'test_helper'

class TitleOrderTest < ActiveSupport::TestCase
  
  def setup
  	@property = build(:address)
  	@buyers_agent = build(:buyers_agent)
  	@sellers_agent = build(:sellers_agent)
    @user = build(:non_admin)
  	@title_order = TitleOrder.new(property: @property, buyers_agent: @buyers_agent, sellers_agent: @sellers_agent, title_type: "Joint marriange", closing_type: "Local", buyers_agent_commission: "2.5%", sellers_agent_commission: "2.5%", survey_requested: true, user: @user)
  end

  test "should be valid" do
  	assert @title_order.valid?
    @title_order.save
    puts @title_order.errors.full_messages
  end

end