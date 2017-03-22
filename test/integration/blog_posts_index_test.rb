require 'test_helper'

class BlogPostsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:non_admin)
    @post = create(:post)
    @posts = []
    5.times {@posts << create(:post)}
    @unpublished = create(:unpublished)
  end

  test "posts index should only show published posts" do
    log_in_as @user
    get blog_posts_path
    assert_template 'blog/posts/index'
    assert_select 'div.post', count: 6
    assert_no_match @unpublished.title, response.body
  end
end