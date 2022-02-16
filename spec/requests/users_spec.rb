require 'rails_helper'

RSpec.describe 'users', type: :request do
  describe 'GET index' do
    before(:each) { get users_path }
    it 'check response status' do
      expect(response).to have_http_status(:ok)
    end
    it 'matches the template' do
      expect(response).to render_template(:index)
    end
    it 'have the correct text in it' do
      expect(response.body).to include('Users')
    end
  end

  describe 'GET show' do
    before(:each) do
      @user = User.create(name: 'John Doe', photo: '', bio: 'Lorem ipsum', posts_counter: 1)
      get user_path(@user.id)
    end
    it 'check response status' do
      expect(response).to have_http_status(:ok)
    end
    it 'matches the template' do
      expect(response).to render_template(:show)
    end
    it 'have the correct text in it' do
      expect(response.body).to include('details')
    end
  end
end
