require 'test_helper'

class TitleOrderIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = create(:admin)
    @user = create(:non_admin)
    @title_order = create(:title_order)
    @other_title_order = create(:other_title_order)
  end

  test "user should be valid" do
    assert @user.valid?, @user.errors.full_messages.inspect
  end

  test "Non-admin should only see his own title orders" do
    log_in_as(@user)
    @user.title_orders << @other_title_order
    get title_orders_path
    assert_template 'title_orders/index'
    assert_select 'div.title-order', count: 1
    assert_match "#{@other_title_order.property.formatted}", response.body
    assert_no_match "#{@title_order.property.formatted}", response.body
  end

  test "Admin should see all title orders" do
    log_in_as(@admin)
    get title_orders_path
    assert_template 'title_orders/index'
    assert_select 'div.title-order', count: 2
    assert_match "#{@other_title_order.property.formatted}", response.body
    assert_match "#{@title_order.property.formatted}", response.body
  end
end