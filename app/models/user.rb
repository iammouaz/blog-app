class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :name, :email, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  def recent_posts
    posts.includes(:comments).order(created_at: :desc).last(3)
  end

  def admin?
    role == 'admin'
  end
end
