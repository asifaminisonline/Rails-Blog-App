require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @user = User.create(name: 'John Doe', photo: 'photo url', bio: 'Awesome bio', posts_counter: 0)
  end

  describe 'validations' do
    it 'validates presence of name' do
      @user.name = nil
      expect(@user).not_to be_valid
      expect(@user.errors[:name]).to include("can't be blank")
    end

    it 'posts_counter is invalid' do
      @user.posts_counter = 'asdasdasd'
      expect(@user).to_not be_valid
    end

    it 'post counter is integer' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end
  end
  describe 'recent_posts' do
    let!(:post1) { Post.create(Title: 'Post 1', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0) }
    let!(:post2) { Post.create(Title: 'Post 2', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0) }
    let!(:post3) { Post.create(Title: 'Post 3', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0) }
    let!(:post4) { Post.create(author: @user) }

    it 'should return the specified number of posts' do
      expect(@user.recent_posts.count).to eq(3)
      expect(@user.recent_posts).to include(post1, post2, post3)
    end
  end
end
