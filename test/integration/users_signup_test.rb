require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
	end

	test "invalid signup information" do
		get new_user_path
		assert_template 'users/new'
		assert_no_difference 'User.count' do
			post users_path, params: { user: { email: "  ",
											   name: " ",
											   password: "  ",
											   password_confirmation: "   "}}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.field_with_errors'
	end

	test "valid signup information" do
		get new_user_path
		assert_template 'users/new'
		assert_difference 'User.count' do
			post users_path, params: { user: { email: "test@example.com",
											   name: "Chris Severns",
											   password: "password",
											   password_confirmation: "password"}}
		end
		assert_equal 1, ActionMailer::Base.deliveries.size
		assert_redirected_to root_path
		user = assigns(:user)
		assert_not user.activated?
		get edit_account_activation_path("invalid token", email: user.email)
		assert_not user.activated?
		get edit_account_activation_path(user.activation_token, email: "wrong")
		assert_not user.activated?
		get edit_account_activation_path(user.activation_token, email: user.email)
		assert user.reload.activated?
		assert_redirected_to user_path(user)
		assert_not flash.empty?
		follow_redirect!
		assert_template 'users/show'
	end
end