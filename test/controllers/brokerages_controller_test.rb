require 'test_helper'

class BrokeragesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get brokerages_show_url
    assert_response :success
  end

end
