class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
    @comments = @post.comments.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      @post.update_counter
      flash[:notice] = 'Post was successfully created.'
      redirect_to [@post.user, @post]
    else
      flash[:alert] = 'Failed to create the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
