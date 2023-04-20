require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'Users Posts', type: :feature do
  let!(:first_user) { User.first }
  let!(:users) { [first_user] }
  let!(:posts) { Post.all }
  first_user = User.create(name: 'Jerry', photo: 'https://unsplash.com/photos/iFgRcqHznqg',
                           bio: 'Teacher from Mexico.', posts_counter: 0)
  first_post = Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id,
                           comments_counter: 0, likes_counter: 0)
  second_post = Post.create(title: 'Second Post', text: 'This is my second post', author_id: first_user.id,
                            comments_counter: 0, likes_counter: 0)
  Post.create(title: 'Third Post', text: 'This is my third post', author_id: first_user.id,
              comments_counter: 0, likes_counter: 0)
  Post.create(title: 'Fourth Post', text: 'This is my fourth post', author_id: first_user.id,
              comments_counter: 0, likes_counter: 0)
  Comment.create(post: first_post, author: first_user, text: 'This is my first comment')
  Like.create(post: first_post, author: first_user)
  before do
    visit user_path(first_user)
  end
  scenario 'I can see the user profile picture' do
    expect(page).to have_css('img')
  end
  scenario 'I can see the username of the user' do
    expect(page).to have_content('Jerry')
  end
  scenario 'I can see the number of posts written by user' do
    expect(page).to have_content(first_user.posts_counter)
  end
  scenario 'I can see the bio of the user' do
    expect(page).to have_content(first_user.bio)
  end
  scenario 'I can see the user first 3 posts' do
    expect(page).to have_content('Fourth Post')
    expect(page).to have_content('Third Post')
    expect(page).to have_content('Second Post')
    expect(page).to_not have_content('First Post')
  end
  scenario 'I can see a link to see all posts' do
    expect(page).to have_link('View all posts')
  end
  scenario 'When I click a user post, it redirects me to that post show page' do
    click_link second_post.title
    expect(page).to have_current_path(user_post_path(first_user.id, second_post.id))
  end
  it 'click on post should redirect to show post' do
    users.each do |user|
      # create post for tested user
      Post.create(author: user, title: 'Hello1', text: 'This is my first post')
      Post.create(author: user, title: 'Hello2', text: 'This is my first post')
      Post.create(author: user, title: 'Hello3', text: 'This is my first post')
      Post.create(author: user, title: 'Hello4', text: 'This is my first post')

      visit "/users/#{user.id}"

      post = user.most_recent_posts.first
      click_on post.title

      expect(has_current_path?("/users/#{user.id}/posts/#{post.id}", wait: 5)).to be_truthy
    end
  end
end
# rubocop:enable Metrics/BlockLength
