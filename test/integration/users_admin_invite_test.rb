class TitleOrderIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = build(:admin)
    @invitee = build(:non_admin)
    ActionMailer::Base.deliveries.clear
  end

  test "send admin invite and activate non-admin" do
    log_in_as(@admin)
    get admin_path(@admin)
    assert_template 'users/admin'
    post admin_invitee_path, params: { admin_invite: { email: @invitee.email}}
    assert_not flash.empty?
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to admin_path(@admin)
    get edit_admin_status_path("invalid token", @invitee.email)
    assert_not flash.empty?
    assert_redirected_to root_path
    assert_not @invitee.admin?
    get edit_admin_status_path(@invitee.admin_token, "bad email")
    assert_not flash.empty?
    assert_redirected_to root_path
    assert_not @invitee.admin?
    get edit_admin_status_path(@invitee.admin_token, @invitee.email)
    assert_not flash.empty?
    assert_redirected_to admin_path(@invitee)
    assert_template 'users/admin'
  end
end