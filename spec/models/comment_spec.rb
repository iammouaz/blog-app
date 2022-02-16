require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.new(name: 'John', posts_counter: 1)
    @post = @user.posts.new(title: 'Lorem Ipsum', comments_counter: 1, likes_counter: 0)
    @comment = @post.comments.new(text: 'New comment', user_id: @user.id)
    @user.save
    @post.save
  end
  it 'check if update_counter from comment works' do
    @comment.update_counter
    expect(@post.comments_counter).to eq(2)
  end
end
