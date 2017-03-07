require 'test_helper'

class TitleOrderTest < ActiveSupport::TestCase
  
  def setup
  	@property = addresses(:office)
  	@buyers_agent = agents(:larry)
  	@sellers_agent = agents(:kevin)
  	@title_order = TitleOrder.new(property: @property, buyers_agent: @buyers_agent, sellers_agent: @sellers_agent, title_type: "Joint marriange", closing_type: "Local", buyers_agent_commission: "2.5%", sellers_agent_commission: "2.5%", survey_requested: true)
  end

  test "should be valid" do
  	assert @title_order.valid?, "#{@title_order.errors.full_messages}"
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