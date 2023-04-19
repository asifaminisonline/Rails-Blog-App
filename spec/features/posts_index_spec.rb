require 'rails_helper'

RSpec.feature 'PostsIndices', type: :feature do
  let(:user) do
    User.create(
      name: 'Example User',
      bio: 'Example Bio',
      photo: 'https://i.imgur.com/8Qq7YQq.jpg'
    )
  end

  let!(:post) do
    Post.create(
      title: 'Example Title',
      text: 'Example Text',
      author_id: user.id
    )
  end

  let!(:comment) do
    Comment.create(
      text: 'Example Comment',
      post_id: post.id,
      author_id: user.id
    )
  end

  let!(:like) do
    Like.create(
      post_id: post.id,
      author_id: user.id
    )
  end

  before do
    visit "/users/#{user.id}/posts"
  end

  it 'displays user image' do
    expect(page).to have_css("img[src*='https://i.imgur.com/8Qq7YQq.jpg']")
  end

  it 'displays user name' do
    expect(page).to have_content('Example User')
  end

  it 'displays number of posts a user has' do
    expect(page).to have_content('1')
  end

  it 'displays post title' do
    expect(page).to have_content('Example Title')
  end

  it 'displays post text' do
    expect(page).to have_content('Example Text')
  end

  it 'displays first comment' do
    expect(page).to have_content('Example Comment')
  end

  it 'displays number of comments' do
    expect(page).to have_content('1')
  end

  it 'displays number of likes' do
    expect(page).to have_text('1')
  end

  describe 'show section of pagination' do
    it 'display the page if there are more posts than fit on the view.' do
      15.times do
        Post.create(
          title: 'Example Title',
          text: 'Example Text',
          author_id: user.id
        )
      end
      visit "/users/#{user.id}/posts"
      expect(page).to have_text('1')
    end
  end
end
