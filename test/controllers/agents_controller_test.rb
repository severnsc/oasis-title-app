require 'test_helper'

class AgentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:non_admin)
    @agent = create(:agent)
  end

  test "should be logged in" do
    get agent_path(@agent)
    assert_redirected_to login_path
    log_in_as(@user)
    assert_redirected_to agent_path(@agent)
    follow_redirect!
    assert_template 'agents/show'
  end
end
