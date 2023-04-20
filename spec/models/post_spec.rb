require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    first_user = User.create(name: 'tom', photo: 'https://images.unsplash.com/photo-1583864697784-a0efc8379f70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',
                             bio: 'Full-Stack Developer', posts_counter: 1)
    first_post = Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id,
                             comments_counter: 0, likes_counter: 0)

    it 'is not valid without a title' do
      first_post.title = nil
      expect(first_post).to_not be_valid
    end

    it 'is not valid if the title is more than 250 characters' do
      first_post = Post.create(
        # rubocop:disable Layout/LineLength
        title: 'This is a very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very looooooooooooooooooooooooooooooooong title', text: 'This is my first post', author_id: first_user.id, likes_counter: 'one'
        # rubocop:enable Layout/LineLength
      )
      expect(first_post).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      subject.likes_counter = 1.5
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      subject.comments_counter = 1.5
      expect(subject).to_not be_valid
    end
  end
  describe '#update_posts_counter' do
    it 'should update posts_counter' do
      first_user = User.create(name: 'tom', photo: 'https://avatars.githubusercontent.com/u/93311467?v=4',
                               bio: 'Full-Stack Developer', posts_counter: 1)
      # rubocop:disable Lint/UselessAssignment
      first_post = Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id,
                               comments_counter: 0, likes_counter: 0)
      # rubocop:enable Lint/UselessAssignment
      expect(first_user.posts_counter).to eq 1
    end
  end
end
