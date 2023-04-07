require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = User.create(name: 'John Doe', photo: 'photo url', bio: 'Awesome bio', posts_counter: 0)
    @post = Post.create(Title: 'Awesome Title', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0)
  end

  describe 'validations' do
    it 'should require a Title' do
      post = Post.new(Text: 'Post body', author: @user)
      expect(post.valid?).to eq(false)
      expect(post.errors[:Title].any?).to eq(true)
    end

    it 'should require a non-empty Title' do
      post = Post.new(Title: '', Text: 'Post body', author: @user)
      expect(post.valid?).to eq(false)
      expect(post.errors[:Title].any?).to eq(true)
    end

    it 'should allow valid attributes' do
      post = Post.new(Title: 'My post', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0)
      expect(post.valid?).to eq(true)
    end

    it 'should validate the CommentsCounter attribute' do
      post = Post.new(Title: 'My post', Text: 'Post body', author: @user, CommentsCounter: -1, LikesCounter: 0)
      expect(post.valid?).to eq(false)
      expect(post.errors[:CommentsCounter].any?).to eq(true)
    end

    it 'should validate the LikesCounter attribute' do
      post = Post.new(Title: 'My post', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: -1)
      expect(post.valid?).to eq(false)
      expect(post.errors[:LikesCounter].any?).to eq(true)
    end

    it 'does not allow title to exceed maximum length' do
      post = Post.new(Title: 'a' * 251, Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:Title]).to include('is too long (maximum is 250 characters)')
    end
  end

  describe 'recent_comments' do
    let(:post) { @post }
    let!(:comment1) { Comment.create(author: @user, post:) }
    let!(:comment2) { Comment.create(author: @user, post:) }
    let!(:comment3) { Comment.create(author: @user, post:) }
    let!(:comment4) { Comment.create(author: @user, post:) }
    let!(:comment5) { Comment.create(author: @user, post:) }
    let!(:comment6) { Comment.create(author: @user, post:) }

    it 'should return the specified number of comments' do
      comment1
      comment2
      comment3
      comment4
      comment5
      comment6
      expect(post.recent_comments(5).count).to eq(5)
    end
  end
end
