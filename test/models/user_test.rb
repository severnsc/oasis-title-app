require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(email: "severnc@gmail.com", password: "password", password_confirmation: "password")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "should have an email" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "email should be valid" do
		invalid_emails = %w[email@gmail email@gmail.com. emailatgmaildotcom emailatgmail.com]
		invalid_emails.each do |email|
			@user.email = email
			assert_not @user.valid?, "#{email} shouldn't be valid"
		end
	end

	test "email should save as downcase" do
		mixed_case_email = "TeSt@ExAmPlE.CoM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

	test "should have password" do
		@user.password = " "*8
		assert_not @user.valid?
	end

	test "password should be 8 chars long" do
		@user.password = "a"*7
		assert_not @user.valid?
	end
end
