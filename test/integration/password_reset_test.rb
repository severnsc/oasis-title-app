require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:user)
    ActionMailer::Base.deliveries.clear
  end

  test "password rest" do
    get new_password_reset_path
    assert_template 'password_reset/new'
    post password_reset_index_path, params: { password_reset: { email: ""}}
    assert_not flash.empty?
    assert_template 'password_reset/new'
    @user.toggle!(:activated)
    post password_reset_index_path, params: { password_reset: { email: @user.email}}
    assert_redirected_to root_path
    assert_not flash.empty?
    @user.toggle!(:activated)
    get new_password_reset_path
    post password_reset_index_path, params: { password_reset: { email: @user.email}}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_path
    user = assigns(:user)
    #bad email
    get edit_password_reset_path(user.reset_token, email: "bad@email.com")
    assert_redirected_to root_path
    #not activated
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_path
    #Right email, wrong token
    user.toggle!(:activated)
    get edit_password_reset_path("token", email: user.email)
    assert_redirected_to root_path
    #Right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_reset/edit'
    #Invalid password & confirmation
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password: 'password',
                                                           password_confirmation: 'password1234'}}
    assert_select 'div#error_explanation'                                                      
    #empty password
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                            user: { password: '',
                                                                    password_confirmation: ''} }
    assert_select 'div#error_explanation'
    #valid password and confirm
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                            user: { password: 'password',
                                                                    password_confirmation: 'password'}}
    assert_nil @user.reload.reset_digest
    assert_not flash.empty?
    assert_redirected_to login_path
  end
end