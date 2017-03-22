require 'test_helper'

class BrokeragesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:non_admin)
    @brokerage = create(:brokerage)
  end

  test "should be logged in to see" do
    get brokerage_path(@brokerage)
    assert_redirected_to login_path
    log_in_as(@user)
    assert_redirected_to brokerage_path(@brokerage)
    follow_redirect!
    assert_template 'brokerages/show'
  end
end
