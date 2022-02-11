require 'rails_helper'

RSpec.describe 'posts', type: :request do
  describe 'GET index' do
    before(:each) do
      @user = User.create(name: 'John Doe', photo: '', bio: 'Lorem ipsum', posts_counter: 1)
      get user_posts_path(@user.id)
    end
    it 'check response status' do
      expect(response).to have_http_status(:ok)
    end
    it 'matches the template' do
      expect(response).to render_template(:index)
    end
    it 'have the correct text in it' do
      expect(response.body).to include('List of recent posts')
    end
  end

  describe 'GET show' do
    before(:each) do
      @user = User.create(name: 'John Doe', photo: '', bio: 'Lorem ipsum', posts_counter: 1)
      @user.posts.new(title: '42', text: 'Answer', user_id: 1, comments_counter: 1, likes_counter: 0)
      @user.save
      get user_post_path(@user.id, @user.posts.first.id)
    end
    it 'check response status' do
      expect(response).to have_http_status(:ok)
    end
    it 'matches the template' do
      expect(response).to render_template(:show)
    end
    it 'have the correct text in it' do
      expect(response.body).to include('Post details')
    end
  end
end
