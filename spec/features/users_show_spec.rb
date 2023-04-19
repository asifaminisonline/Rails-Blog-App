require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:user) { User.create(name: 'Example User', bio: 'Example Bio', photo: 'https://i.imgur.com/8Qq7YQq.jpg') }
  let!(:post) { Post.create(title: 'Example Title', text: 'Example Text', author_id: user.id) }
  let!(:comment) { Comment.create(text: 'Example Text', author_id: user.id, post_id: post.id) }
  let!(:like) { Like.create(post_id: post.id, author_id: user.id) }

  before { visit "/users/#{user.id}/" }

  it 'displays user image' do
    expect(page).to have_css("img[src*='https://i.imgur.com/8Qq7YQq.jpg']")
  end

  it 'displays user name' do
    expect(page).to have_content('Example User')
  end

  it 'displays number of posts a user has' do
    expect(page).to have_content('1')
  end

  it 'displays the user bio' do
    expect(page).to have_content('Example Bio')
  end

  it 'returns the 3 most recent posts' do
    user = User.create(name: 'User1')
    user.posts.create(title: 'Post 1', text: 'Post 1 text') # post1
    user.posts.create(title: 'Post 2', text: 'Post 2 text') # post2
    post3 = user.posts.create(title: 'Post 3', text: 'Post 3 text')
    post4 = user.posts.create(title: 'Post 4', text: 'Post 4 text')
    post5 = user.posts.create(title: 'Post 5', text: 'Post 5 text')
    expect(user.most_recent_posts).to eq([post5, post4, post3])
  end


  it 'displays a button to view all posts' do
    expect(page).to have_link('See All Posts')
  end

  describe 'User posts page' do
    let!(:user) { User.create(name: 'Example User', bio: 'Example Bio', photo: 'https://i.imgur.com/8Qq7YQq.jpg') }
    let!(:post1) { user.posts.create(title: 'Post 1', text: 'Lorem ipsum') }
    let!(:post2) { user.posts.create(title: 'Post 2', text: 'Dolor sit amet') }
    before do
      visit user_posts_path(user)
    end

    it "takes you to the post's show page" do
      click_link post1.title
      expect(page).to have_current_path(user_post_path(user, post1))
    end
  end

  describe 'post index page' do
    let!(:user) { User.create(name: 'Example User', bio: 'Example Bio', photo: 'https://i.imgur.com/8Qq7YQq.jpg') }
    let!(:post1) { user.posts.create(title: 'Post 1', text: 'Lorem ipsum') }
    let!(:post2) { user.posts.create(title: 'Post 2', text: 'Dolor sit amet') }

    it 'displays the posts index page when you click see all posts' do
      visit user_path(user)
      click_link 'See All Posts'
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
