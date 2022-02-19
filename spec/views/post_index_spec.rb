require 'rails_helper'

RSpec.describe 'User index', type: :system do
  describe 'Check the content without post' do
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
      visit user_posts_path(@user.id)
    end
    it 'if shows the main user photo' do
      expect(page).to have_xpath("//img[contains(@src,'https://i.pravatar.cc/200?img=3')]")
    end
    it 'if shows the main user name' do
      expect(page).to have_content('Joe')
    end
  end
  describe 'Check the content with a post' do
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
      sleep(1)
      visit user_posts_path(@user.id)
      sleep(1)
      click_link 'New Post'
      sleep(1)
      fill_in 'post_title', with: 'asd'
      fill_in 'post_text', with: 'lorem ipsum'
      click_button 'Create Post'
      sleep(1)
      visit user_posts_path(@user.id)
    end
    it 'if shows the main user photo' do
      expect(page).to have_xpath("//img[contains(@src,'https://i.pravatar.cc/200?img=3')]")
    end
    it 'if shows the main user name' do
      expect(page).to have_content('Joe')
    end
    it 'if number of posts is updated' do
      expect(page).to have_content('Number of posts: 1')
    end
    it 'if shows posts title' do
      expect(page).to have_content('asd')
    end
    it 'if shows posts body' do
      expect(page).to have_content('lorem ipsum')
    end
  end
  describe 'Check the content of posts with comments' do
    before(:each) do
      @user = User.new(name: 'Joe', photo: 'https://i.pravatar.cc/200?img=3', bio: 'joe bio', posts_counter: 0,
                       email: 'joe@mail.com', password: 'pass123')
      @user.skip_confirmation!
      @user.save
      @post = @user.posts.new(title: 'asd', text: 'lorem ipsum', user_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
      @post.save
      visit root_path
      sleep(2)
      fill_in 'user_email', with: 'joe@mail.com'
      fill_in 'user_password', with: 'pass123'
      click_button 'Log in'
      sleep(1)
      (1..6).each do |n|
        visit user_post_path(user_id: @user.id, id: @post.id)
        click_link 'Create new comment'
        sleep(1)
        fill_in 'comment_text', with: "comment #{n}"
        click_button 'Save Comment'
        sleep(1)
      end
    end
    it 'if shows the newest 5 comments' do
      expect(page).to have_content('comment 2')
      expect(page).to have_content('comment 3')
      expect(page).to have_content('comment 4')
      expect(page).to have_content('comment 5')
      expect(page).to have_content('comment 6')
    end
    it 'if shows the number of comments' do
      expect(page).to have_content('Comments: 6')
    end
    it 'if shows the number of likes' do
      click_link 'Post details'
      click_button 'Like this post'
      visit user_post_path(user_id: @user.id, id: @post.id)
      expect(page).to have_content('Likes: 1')
    end
    it 'if shows the pagination button' do
      expect(page).to have_content('Pagination')
    end
    it 'if redirects to the posts show page when Post details is clicked' do
      first(:link, 'Post details').click
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
    end
  end
end
