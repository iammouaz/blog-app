module Api
  class PostsController < ApplicationController
    before_action :authenticate_user!
    def index
      @posts = Post.all.order('created_at')
      render json: @posts, status: :ok
    end

    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        @post.increase_counter
        render json: { message: 'You successfully created a new post' }, status: :created
      else
        render json: { message: 'Something is wrong when you tried to create a new post' }, status: :bad_request
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
    end
  end
end
