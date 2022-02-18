require 'rails_helper'

RSpec.describe 'User index', type: :system do
  describe 'Check the content of posts with comments' do
    before(:each) do
      @user = User.new(name: 'Joe', photo: 'https://i.pravatar.cc/200?img=3', bio: 'joe bio', posts_counter: 1,
                       email: 'joe@mail.com', password: 'pass123')
      @user.skip_confirmation!
      @user.save
      @user2 = User.new(name: 'Maria', photo: 'https://i.pravatar.cc/200?img=5', bio: 'maria bio', posts_counter: 0,
                        email: 'maria@mail.com', password: 'pass123')
      @user2.skip_confirmation!
      @user2.save
      @post = @user.posts.new(title: 'asd', text: 'lorem ipsum', user_id: @user.id, comments_counter: 2,
                              likes_counter: 0)
      @post.save
      @comment = @post.comments.new(text: 'text comment', user_id: @user.id, post_id: @post.id)
      @comment.save
      @comment2 = @post.comments.new(text: 'text comment 2', user_id: @user2.id, post_id: @post.id)
      @comment2.save
      visit root_path
      sleep(2)
      fill_in 'user_email', with: 'joe@mail.com'
      fill_in 'user_password', with: 'pass123'
      click_button 'Log in'
      visit user_post_path(user_id: @user.id, id: @post.id)
      sleep(2)
    end
    it 'if shows the post title' do
      expect(page).to have_content('asd')
    end
    it 'if shows the author of the post' do
      expect(page).to have_content('by Joe')
    end
    it 'if shows the number of comments' do
      expect(page).to have_content('Comments: 2')
    end
    it 'if shows the number of likes' do
      expect(page).to have_content('Likes: 0')
    end
    it 'if shows the post body' do
      expect(page).to have_content('lorem ipsum')
    end
    it 'if shows the username of each commentor.' do
      expect(page).to have_content("#{@user.name}: \n#{@comment.text}")
    end
    it 'if shows the username of each commentor.' do
      expect(page).to have_content("#{@user.name}: \n#{@comment.text}")
    end
    it 'if shows the comment each commentor left.' do
      expect(page).to have_content("#{@user2.name}: \n#{@comment2.text}")
    end
  end
end
