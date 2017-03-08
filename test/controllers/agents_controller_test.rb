require 'test_helper'

class AgentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get agents_show_url
    assert_response :success
  end

end
