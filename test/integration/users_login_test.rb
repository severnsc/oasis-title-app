class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = create(:admin)
	end

	test "invalid login info" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: { email: @user.email,
											  password: "bad"}}
		assert_template 'sessions/new'
		assert_not flash.empty?
		assert_select 'div.alert'
	end

	test "valid login info" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: { email: @user.email,
											  password: "password"}}
		flash.each {|k, v| puts v}
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_template 'users/show'
	end
end