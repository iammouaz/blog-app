module Api
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    def index
      @post = Post.includes(:comments).find_by(id: params[:post_id])
      render json: @post.comments, status: :ok
    end

    def create
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      @comment.post = Post.find(params[:post_id])
      if @comment.save
        @comment.increase_counter
        render json: { message: 'You successfully created a new comment' }, status: :created
      else
        render json: { message: 'Something is wrong when you tried to create a new comment' }, status: :bad_request
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:text)
    end
  end
end
