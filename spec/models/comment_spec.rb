require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to author' do
      comment = Comment.reflect_on_association(:author)
      expect(comment.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    before(:each) do
      @user = User.create(name: 'User 1', posts_counter: 0)
      @post = @user.posts.create(title: 'Post 1', text: 'Post 1 text')
    end
    it 'is valid with valid attributes' do
      comment = Comment.new(text: 'Comment 1', author: @user, post: @post)
      expect(comment).to be_valid
    end

    it 'is not valid without a text' do
      comment = Comment.new(text: nil, author: @user, post: @post)
      expect(comment).to_not be_valid
    end
  end

  describe 'update_comments_counter' do
    it 'increments the comments_counter of the post by 1' do
      user = User.create(name: 'User 1')
      post = Post.create(title: 'Post 1', text: 'Post 1 text', author: user)
      Comment.create(text: 'Comment 1', author: user, post: post)
      expect(post.comments_counter).to eq(1)
    end
  end
end
