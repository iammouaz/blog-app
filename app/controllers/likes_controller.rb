class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: current_user)
    if @like.save
      @like.update_counter
      flash[:notice] = 'You successfully liked the post.'
    else
      flash[:alert] = 'You were unable to give this post a like.'
    end
  end
end
