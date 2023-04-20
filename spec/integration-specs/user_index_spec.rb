require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  let!(:first_user) { User.first }
  let!(:second_user) { User.second }
  let!(:users) { [first_user] }
  let!(:posts) { Post.all }

  before(:example) do
    first_user = User.create(name: 'Jerry', photo: 'https://unsplash.com/photos/iFgRcqHznqg',
                             bio: 'Teacher from Mexico.', posts_counter: 0)
    Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id,
                comments_counter: 0, likes_counter: 0)
    visit users_path
  end

  describe 'GET /users' do
    it 'I can see the username of all other users' do
      expect(page).to have_content('Jerry')
    end

    it 'I can see the profile picture for all other users' do
      expect(page).to have_css('img')
    end

    it 'I can see the number of posts each user has written' do
      expect(page).to have_content('1')
    end

    context 'when I click on a user' do
      it 'username of all users' do
        users.each do |user|
          visit "/users/#{user.id}"
          expect(page).to have_text(user.name)
        end
      end

      it 'can see the user profile picture' do
        users.each do |user|
          visit "/users/#{user.id}"
          expect(page).to have_selector("img[src='#{user.photo}']")
        end
      end
    end
  end
end
