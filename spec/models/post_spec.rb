require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'belongs to author' do
      post = Post.reflect_on_association(:author)
      expect(post.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eq(:has_many)
    end

    it 'has many likes' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    before(:each) do
      @user = User.create(name: 'User 1', posts_counter: 0)
    end
    it 'is valid with valid attributes' do
      post = Post.new(title: 'Post 1', author: @user, comments_counter: 0, likes_counter: 0)
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(title: nil, author: @user, comments_counter: 0, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid with a negative comments_counter' do
      post = Post.new(title: 'Post 1', author: @user, comments_counter: -1, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid with a negative likes_counter' do
      post = Post.new(title: 'Post 1', author: @user, comments_counter: 0, likes_counter: -1)
      expect(post).to_not be_valid
    end
  end

  describe 'recent_comments' do
    it 'returns the 5 most recent comments' do
      user = User.create(name: 'User 1')
      post = user.posts.create(title: 'Post 1', text: 'Post 1 text')
      post.comments.create(text: 'Comment 1', author: user) # comment1
      comment2 = post.comments.create(text: 'Comment 2', author: user)
      comment3 = post.comments.create(text: 'Comment 3', author: user)
      comment4 = post.comments.create(text: 'Comment 4', author: user)
      comment5 = post.comments.create(text: 'Comment 5', author: user)
      comment6 = post.comments.create(text: 'Comment 6', author: user)
      expect(post.recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end

  describe 'update_post_counter' do
    it 'increments the author posts_counter by 1' do
      user = User.create(name: 'User 1', posts_counter: 0)
      Post.create(title: 'Post 1', author: user, comments_counter: 0, likes_counter: 0)
      expect(user.posts_counter).to eq(1)
    end
  end
end
