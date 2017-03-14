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
  end

  test "should have a property" do
  	@title_order.property  = nil
  	assert_not @title_order.valid?
  end

  test "should have a buyers agent" do
  	@title_order.buyers_agent = nil
  	assert_not @title_order.valid?
  end

  test "should have a sellers agent" do
  	@title_order.sellers_agent = nil
  	assert_not @title_order.valid?
  end

  test "should have title type" do
  	@title_order.title_type = "  "
  	assert_not @title_order.valid?
  end

  test "should have a closing type" do
  	@title_order.closing_type = "  "
  	assert_not @title_order.valid?
  end

  test "should have a buyers agent commission" do
  	@title_order.buyers_agent_commission = "  "
  	assert_not @title_order.valid?
  end

  test "should have a sellers agent commission" do
  	@title_order.sellers_agent_commission = " "
  	assert_not @title_order.valid?
  end

  test "should have a survey requested" do
  	@title_order.survey_requested = nil
  	assert_not @title_order.valid?
  end
end