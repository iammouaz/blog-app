class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(text: comment_params[:text], user: current_user)

    respond_to do |format|
      format.html do
        if @comment.save
          @comment.update_counter
          flash[:notice] = 'Comment was successfully created.'
          redirect_to user_posts_path
        else
          flash[:alert] = 'Failed to create the comment.'
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
