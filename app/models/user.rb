class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  def recent_posts(id)
    Post.order('created_at Desc').limit(3)  end
end
