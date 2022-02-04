class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  def recent_posts(id)
    Post.where(user_id: id).last(3)
  end
end
