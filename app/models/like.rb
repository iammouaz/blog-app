class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_counter(id)
    post = Post.find_by(id: id)
    post.likes_counter = Like.where(post_id: id).count
    post.save
  end
end
