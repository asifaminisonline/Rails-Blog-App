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


  let!(:user) { User.create(name: 'Example User', bio: 'Example Bio', photo: 'https://i.imgur.com/8Qq7YQq.jpg') }

  before do
    visit users_path
  end
  it "takes you to the user's show page" do
    click_link user.name
    expect(page).to have_current_path(user_path(user))
  end
end
