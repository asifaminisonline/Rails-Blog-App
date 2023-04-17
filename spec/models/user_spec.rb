require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'John', posts_counter: 0)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil, posts_counter: 0)
      expect(user).to_not be_valid
    end

    it 'is not valid with a negative posts_counter' do
      user = User.new(name: 'John', posts_counter: -1)
      expect(user).to_not be_valid
    end
  end

  describe 'recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'User1')
      user.posts.create(title: 'Post 1', text: 'Post 1 text') # post1
      user.posts.create(title: 'Post 2', text: 'Post 2 text') # post2
      post3 = user.posts.create(title: 'Post 3', text: 'Post 3 text')
      post4 = user.posts.create(title: 'Post 4', text: 'Post 4 text')
      post5 = user.posts.create(title: 'Post 5', text: 'Post 5 text')
      expect(user.recent_posts).to eq([post5, post4, post3])
    end
  end
end
