class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250, too_long: 'Maximum of 250 characters' }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def recent_comments
    comments.order(created_at: :desc).first(5)
  end

  def increase_counter
    user.posts_counter = 0 if user.posts_counter.nil?
    user.posts_counter += 1
    user.save
  end

  def decrease_counter
    return if user.posts_counter <= 0 || user.posts_counter.nil?

    user.posts_counter -= 1
    user.save
  end
end
