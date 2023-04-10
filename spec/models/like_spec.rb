require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to author' do
      like = Like.reflect_on_association(:author)
      expect(like.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    before(:each) do
      @user = User.create(name: 'User 1', posts_counter: 0)
      @post = @user.posts.create(title: 'Post 1', text: 'Post 1 text')
    end
    it 'is valid with valid attributes' do
      like = Like.new(author: @user, post: @post)
      expect(like).to be_valid
    end
  end

  describe 'update_likes_counter' do
    it 'increments the likes_counter of the post by 1' do
      user = User.create(name: 'User 1')
      post = Post.create(title: 'Post 1', text: 'Post 1 text', author: user)
      Like.create(author: user, post: post)
      expect(post.likes_counter).to eq(1)
    end
  end
end
