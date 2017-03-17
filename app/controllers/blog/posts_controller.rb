class Blog::PostsController < ApplicationController
  before_action :is_admin?, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "Post created!"
      redirect_to blog_post_path(@post)
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
     flash[:success] = "Post updated!"
     redirect_to blog_post_path(@post)
    else
     render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    flash[:success] = "Post deleted!"
    redirect_to current_user
  end

  private

  def is_admin?
    redirect_to blog_posts_path unless current_user.admin?
  end

  def post_params
    params.require(:post).permit(:body, :title, :bootsy_image_gallery_id)
  end
end