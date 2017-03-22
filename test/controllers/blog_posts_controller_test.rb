require 'test_helper'
require 'database_cleaner'

class BlogPostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = create(:admin)
    @non_admin = create(:non_admin)
    @gallery = create(:gallery)
    @post = create(:post)
  end

  teardown do
    DatabaseCleaner.strategy = :truncation
  end

  test "getting new post page as non-admin redirects" do
    log_in_as(@non_admin)
    get new_blog_post_path
    assert_redirected_to blog_posts_path
    follow_redirect!
    assert_template 'blog/posts/index'
    log_in_as(@admin)
    get new_blog_post_path
    assert_template 'blog/posts/new'
  end

  test "creating new post as non-admin fails" do
    log_in_as(@non_admin)
    assert_no_difference 'Post.count' do
      post blog_posts_path, params: { post: { title: "Post",
                                              body: "body",
                                              status: "published"}}
    end
    log_in_as(@admin)
    assert_difference 'Post.count' do
      post blog_posts_path, params: { post: { title: "Post",
                                              body: "body",
                                              status: "published"}}
    end
    post = assigns(:post)
    assert_not flash.empty?
    assert_redirected_to blog_post_path(post)
  end

  test "getting edit post page as non-admin redirects" do
    log_in_as(@non_admin)
    get edit_blog_post_path(@post)
    assert_redirected_to blog_posts_path
    follow_redirect!
    assert_template 'blog/posts/index'
    log_in_as(@admin)
    get edit_blog_post_path(@post)
    assert_template 'blog/posts/edit'
  end

  test "updating post fails when non-admin" do
    log_in_as(@non_admin)
    title = "New Title"
    body = "New body"
    patch blog_post_path(@post), params: { post: { title: title,
                                                  body: body}}
    assert_not_equal title, @post.reload.title
    assert_not_equal body, @post.reload.body
    log_in_as(@admin)
    patch blog_post_path(@post), params: { post: { title: title,
                                                  body: body}}
    assert_equal title, @post.reload.title
    assert_equal body, @post.reload.body                                                  
  end

  test "destroying post as non-admin fails" do
    log_in_as(@non_admin)
    assert_no_difference 'Post.count' do
      delete blog_post_path(@post)
    end
    logout
    log_in_as(@admin)
    assert_difference 'Post.count', -1 do
      delete blog_post_path(@post)
    end
    assert_not flash.empty?
    assert_redirected_to user_path(@admin)
    follow_redirect!
    assert_template 'users/show'
  end

end