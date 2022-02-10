class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: current_user)
    @like.update_counter if @like.save
    redirect_to [@post.user, @post]
  end
end
