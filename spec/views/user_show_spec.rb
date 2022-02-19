require 'rails_helper'

RSpec.describe 'User index', type: :system do
  describe 'Check the contenct' do
    before(:each) do
      @user = User.new(name: 'Joe', photo: 'https://i.pravatar.cc/200?img=3', bio: 'joe bio', posts_counter: 0,
                       email: 'joe@mail.com', password: 'pass123')
      @user.skip_confirmation!
      @user.save
      visit root_path
      sleep(2)
      fill_in 'user_email', with: 'joe@mail.com'
      fill_in 'user_password', with: 'pass123'
      click_button 'Log in'
      sleep(2)
    end
    it 'shows user profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'https://i.pravatar.cc/200?img=3')]")
    end
    it 'shows user name' do
      expect(page).to have_content('Joe')
    end
    it 'shows user number of posts' do
      expect(page).to have_content('Number of posts: 0')
    end
    it 'shows user bio' do
      expect(page).to have_content('joe bio')
    end
    it 'redirects to post show page' do
      visit user_posts_path(@user.id)
      click_link 'New Post'
      sleep(1)
      fill_in 'post_title', with: 'post'
      fill_in 'post_text', with: 'lorem ipsum'
      click_button 'Create Post'
      sleep(1)
      visit user_path(id: @user.id)
      first(:link, 'See all posts from this user').click
      sleep(1)
      first(:link, 'Post details').click
      expect(page).to have_content("post by #{@user.name}")
    end

    it 'it redirects to the correct path' do
      visit user_posts_path(@user.id)
      click_link 'New Post'
      sleep(1)
      fill_in 'post_title', with: 'post'
      fill_in 'post_text', with: 'lorem ipsum'
      click_button 'Create Post'
      sleep(1)
      visit user_path(id: @user.id)
      sleep(1)
      first(:link, 'See all posts from this user').click
      expect(page).to have_current_path(user_posts_path(user_id: @user.id))
    end
  end

  describe 'Check the posts' do
    before(:each) do
      @user = User.new(name: 'Joe', photo: 'https://i.pravatar.cc/200?img=3', bio: 'joe bio', posts_counter: 0,
                       email: 'joe@mail.com', password: 'pass123')
      @user.skip_confirmation!
      @user.save
      visit root_path
      sleep(2)
      fill_in 'user_email', with: 'joe@mail.com'
      fill_in 'user_password', with: 'pass123'
      click_button 'Log in'
      sleep(2)
      (1..4).each do |n|
        visit user_posts_path(@user.id)
        click_link 'New Post'
        sleep(1)
        fill_in 'post_title', with: "post #{n}"
        fill_in 'post_text', with: 'lorem ipsum'
        click_button 'Create Post'
        sleep(1)
      end
    end
    it 'it shows the last 3 posts' do
      visit user_path(id: @user.id)
      expect(page).to have_content('post 1')
      expect(page).to have_content('post 2')
      expect(page).to have_content('post 3')
      expect(page).to_not have_content('post 4')
    end
    it 'it shows all the posts' do
      visit user_path(id: @user.id)
      sleep(1)
      first(:link, 'See all posts from this user').click
      expect(page).to have_content('post 1')
      expect(page).to have_content('post 2')
      expect(page).to have_content('post 3')
      expect(page).to have_content('post 4')
    end
    it 'it shows all the posts' do
      visit user_path(id: @user.id)
      sleep(1)
      first(:link, 'See all posts from this user').click
      expect(page).to have_content('post 1')
      expect(page).to have_content('post 2')
      expect(page).to have_content('post 3')
      expect(page).to have_content('post 4')
    end
  end
end
