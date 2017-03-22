require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = create(:non_admin)
    @post = Post.new(title: "Title", body: "Body", status: "published", user: @user)
  end

  test "should be valid" do
    assert @post.valid?
  end
end
