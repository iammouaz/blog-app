require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'John', photo: 'https://i.pravatar.cc/200?img=3', bio: 'john bio', posts_counter: 1,
                     email: 'john@mail.com', password: 'pass123')
    @user.skip_confirmation!
    @post = @user.posts.new(title: 'Lorem Ipsum', text: 'some text', comments_counter: 0, likes_counter: 0)
    @user.save
  end
  describe 'check if title' do
    it 'is valid' do
      expect(@post).to be_valid
    end
    it 'is not valid for nil' do
      @post.title = nil
      expect(@post).to_not be_valid
    end
    it 'is not valid for long string' do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end
  end
  describe 'check if comments_counter' do
    it 'is valid' do
      expect(@post).to be_valid
    end
    it 'is not valid for nil' do
      @post.comments_counter = nil
      expect(@post).to_not be_valid
    end
    it 'is not valid for negative numbers' do
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end
  end
  describe 'check if likes_counter' do
    it 'is valid' do
      expect(@post).to be_valid
    end
    it 'is not valid for nil' do
      @post.likes_counter = nil
      expect(@post).to_not be_valid
    end
    it 'is not valid for negative numbers' do
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end
  end
  it 'check if increase_counter method updates user' do
    @post.increase_counter
    expect(@user.posts_counter).to eq(2)
  end
  describe 'check if comments post' do
    before(:each) do
      (1..6).each do |n|
        @post.comments.new(text: "t#{n}", user_id: @user.id)
      end
      @post.save
    end
    it ', recent comments, has length of 5' do
      expect(@post.recent_comments.length).to eq(5)
    end
    it 'allows an invalid post being added' do
      @post.comments.new(text: 't5')
      @post.save
      expect(@post.comments.all.length).to_not eq(7)
    end
  end
end
