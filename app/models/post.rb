class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def recent_comments(id)
    Comments.order('created_at Desc').limit(5)
    Comment.where(post_id: id).last(5)
  end

  def update_counter(id)
    user = User.find_by(id: id)
    user.posts_counter = Post.where(user_id: id).count
    user.save
  end
end
