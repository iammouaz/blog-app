require 'rails_helper'

RSpec.describe 'posts', type: :request do
  describe 'GET index' do
    before(:each) { get user_posts_path(1) }
    it 'check response status' do
      expect(response).to have_http_status(:ok)
    end
    it 'matches the template' do
      expect(response).to render_template(:index)
    end
    it 'have the correct text in it' do
      expect(response.body).to include('List of posts')
    end
  end

  describe 'GET show' do
    before(:each) { get user_post_path(1, 1) }
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
