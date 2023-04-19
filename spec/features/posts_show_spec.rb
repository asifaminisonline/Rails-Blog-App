require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:user) { User.create(name: 'Example User', bio: 'Example Bio', photo: 'https://i.imgur.com/8Qq7YQq.jpg') }
  let!(:post) { Post.create(title: 'Example Title', text: 'Example Text', author_id: user.id) }
  let!(:comment) { Comment.create(text: 'Example Text', author_id: user.id, post_id: post.id) }
  let!(:like) { Like.create(post_id: post.id, author_id: user.id) }

  before { visit "/users/#{user.id}/posts" }

  it 'displays the post title' do
    expect(page).to have_content('Example Title')
  end

  it 'displays the post author' do
    expect(page).to have_content('Example User')
  end

  it 'displays the number of comments on a post' do
    expect(page).to have_content('1')
  end

  it 'displays the number of likes on a post' do
    expect(page).to have_content('1')
  end

  it 'displays the post text' do
    expect(page).to have_content('Example Text')
  end

  it 'displays the comment author' do
    expect(page).to have_content('Example User')
  end

  it 'displays the comment text' do
    expect(page).to have_content('Example Text')
  end
end
