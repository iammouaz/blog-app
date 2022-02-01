class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_counter(id)
    post = Post.find_by(id: id)
    post.comments_counter = Comment.where(post_id: id).count
    post.save
  end
end
