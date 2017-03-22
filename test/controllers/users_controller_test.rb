require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = create(:non_admin)
    @admin = create(:admin)
    @other_admin = create(:admin)
    ActionMailer::Base.deliveries.clear
  end

  test "user should be logged in to see show" do
    get user_path(@user)
    assert_redirected_to login_path
    log_in_as(@user)
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_template 'users/show'
  end

  test "user should be logged in to see admin" do
    get admin_path(@admin)
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to admin_path(@admin)
    follow_redirect!
    assert_template 'users/admin'
  end

  test "user should be logged in for admin invite" do
    post admin_invite_path(@admin), params: { admin_invite: {email: @user.email}}
    assert_redirected_to login_path
  end

  test "only admins can see admin pages" do
    log_in_as(@user)
    get admin_path(@admin)
    assert_redirected_to user_path(@user)
    assert_no_difference ActionMailer::Base.deliveries.size.to_s do
      post admin_invite_path, params: { admin_invite: { email: @user.email}}
    end
    assert_redirected_to user_path(@user)
    log_in_as(@admin)
    get admin_path(@admin)
    assert_template 'users/admin'
    post admin_invite_path, params: {admin_invite: { email: @user.email}}
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to admin_path(@admin)
    assert_not flash.empty?
  end

  test "only the correct user can see edit pages" do
    log_in_as(@admin)
    get edit_user_path(@user)
    assert_redirected_to user_path(@admin)
    email = 'user123@me.com'
    patch user_path(@user), params: { user: { email: email}}
    assert_not_equal email, @user.reload.email
    assert_redirected_to user_path(@admin)
    get admin_path(@other_admin)
    assert_redirected_to user_path(@admin)
    assert_no_difference ActionMailer::Base.deliveries.size.to_s do
      post admin_invite_path(@other_admin), params: { admin_invite: { email: @user.email }}
    end
    assert_redirected_to user_path(@admin)
  end
end
