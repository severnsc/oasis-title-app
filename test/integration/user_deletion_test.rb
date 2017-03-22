require 'test_helper'

class UserDeletionTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:non_admin)
    @other_user = create(:non_admin)
    @admin = create(:admin)
  end

  test "not logged in and wrong user can't delete" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_path
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to user_path(@other_user)
  end

  test "should be able to delete self" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_match "Delete Your Profile", response.body
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end

  test "admin can delete others" do
    log_in_as(@admin)
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
    assert_redirected_to user_path(@admin)
    assert_not flash.empty?
  end
end