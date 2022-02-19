require 'rails_helper'

RSpec.describe 'User index', type: :system do
  describe 'Check the content' do
    before(:each) do
      @user = User.new(name: 'Joe', photo: 'https://i.pravatar.cc/200?img=3', bio: 'joe bio', posts_counter: 0,
                       email: 'joe@mail.com', password: 'pass123')
      @user.skip_confirmation!
      @user.save
      @user2 = User.new(name: 'Maria', photo: 'https://i.pravatar.cc/200?img=5', bio: 'maria bio', posts_counter: 0,
                        email: 'maria@mail.com', password: 'pass123')
      @user2.skip_confirmation!
      @user2.save
      visit root_path
      sleep(2)
      fill_in 'user_email', with: 'joe@mail.com'
      fill_in 'user_password', with: 'pass123'
      click_button 'Log in'
      sleep(2)
      visit users_path
    end
    it 'if shows all users names' do
      expect(page).to have_content('Joe')
      expect(page).to have_content('Maria')
    end
    it 'if shows all users pictures' do
      expect(page).to have_xpath("//img[contains(@src,'https://i.pravatar.cc/200?img=3')]")
      expect(page).to have_xpath("//img[contains(@src,'https://i.pravatar.cc/200?img=5')]")
    end
    it 'if post_counter is working' do
      visit user_posts_path(@user.id)
      click_link 'New Post'
      sleep(1)
      fill_in 'post_title', with: 'asd'
      fill_in 'post_text', with: 'lorem ipsum'
      click_button 'Create Post'
      sleep(1)
      visit users_path
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Number of posts: 0')
    end
    it 'if clicking show this user goes to the users show page' do
      first(:link, 'Show this user').click
      sleep(1)
      expect(page).to have_content('joe bio')
    end
  end
end
