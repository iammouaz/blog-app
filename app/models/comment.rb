class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def increase_counter
    post.comments_counter = 0 if post.comments_counter.nil?
    post.comments_counter += 1
    post.save
  end

  def decrease_counter
    return if post.comments_counter <= 0 || post.comments_counter.nil?

    post.comments_counter -= 1
    post.save
  end
end
