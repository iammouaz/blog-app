require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'John', photo: 'https://i.pravatar.cc/200?img=3', bio: 'john bio', posts_counter: 0,
                     email: 'john@mail.com', password: 'pass123')
    @user.skip_confirmation!
    @user.save
  end
  describe 'check if name' do
    it 'is valid' do
      expect(@user).to be_valid
    end
    it 'is not valid for nil' do
      @user.name = nil
      expect(@user).to_not be_valid
    end
  end
  describe 'check if posts_counter' do
    it 'is valid' do
      expect(@user).to be_valid
    end
    it 'is invalid for negative numbers' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end
  end
  describe 'check if user posts' do
    before(:each) do
      (1..4).each do |n|
        @user.posts.new(title: "t#{n}", comments_counter: 0, likes_counter: 0)
      end
      @user.save
    end
    it ',recent posts, has length of 3' do
      expect(@user.recent_posts.length).to eq(3)
    end
    it 'allows an invalid post being added' do
      @user.posts.new(title: 't5')
      @user.save
      expect(@user.posts.all.length).to_not eq(5)
    end
  end
end
