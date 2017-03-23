require 'test_helper'

class UserAdminInviteTest < ActionDispatch::IntegrationTest

  def setup
    @admin = create(:admin)
    @invitee = create(:non_admin)
    ActionMailer::Base.deliveries.clear
  end

  test "send admin invite and activate non-admin" do
    log_in_as(@admin)
    get admin_path(@admin)
    assert_template 'users/admin'
    post admin_invite_path, params: { admin_invite: { email: @invitee.email}}
    @invitee.admin_token = 'token'
    @invitee.admin_digest = User.digest('token')
    @invitee.save
    assert_not flash.empty?
    assert_equal 2, ActionMailer::Base.deliveries.size
    assert_redirected_to admin_path(@admin)
    get edit_admin_status_path("invalid token", email: @invitee.email)
    assert_not flash.empty?
    assert_redirected_to root_path
    assert_not @invitee.admin?
    get edit_admin_status_path(@invitee.admin_token, email: "bad email")
    assert_not flash.empty?
    assert_redirected_to root_path
    assert_not @invitee.admin?
    get edit_admin_status_path(@invitee.admin_token, email: @invitee.email)
    assert_equal 4, ActionMailer::Base.deliveries.size
    assert @invitee.reload.admin?
    assert_not flash.empty?
    assert_redirected_to admin_path(@invitee)
    follow_redirect!
    assert_template 'users/admin'
  end
end