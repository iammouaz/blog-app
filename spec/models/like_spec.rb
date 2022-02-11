require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.new(name: 'John', posts_counter: 1)
    @post = @user.posts.new(title: 'Lorem Ipsum', comments_counter: 1, likes_counter: 0)
    @like = @post.likes.new(user_id: @user.id)
    @user.save
    @post.save
  end
  it 'check if update_counter from like works' do
    @like.update_counter
    expect(@post.likes_counter).to eq(1)
  end
end
