require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validations' do
    first_user = User.create(name: 'Tom',
                             photo: 'https://images.unsplash.com/photo-1583864697784-a0efc8379f70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80', bio: 'Teacher from Mexico.', posts_counter: 0)
    first_post = Post.create(author: first_user, title: 'Hello', text: 'Thi
        s is my first post', comments_counter: 0, likes_counter: 0)
    first_like = Like.create(author_id: first_user.id, post_id: first_post.id)

    it 'is not valid without a users_id' do
      first_like.author_id = nil
      expect(first_like).to_not be_valid
    end

    it 'is not valid without a posts_id' do
      first_like.post_id = nil
      expect(first_like).to_not be_valid
    end

    it 'posts likes count should be 0' do
      expect(first_post.likes_counter).to eq 0
    end
  end
  describe '#update_posts_like_counter' do
    it 'should update the posts like counter' do
      first_user = User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1583864697784-a0efc8379f70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',
                               bio: 'Teacher from Mexico.', posts_counter: 0)
      first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                               likes_counter: 0)
      # rubocop:disable Lint/UselessAssignment
      first_like = Like.create(author: first_user, post: first_post)
      # rubocop:enable Lint/UselessAssignment
      expect(first_post.likes_counter).to eq 1
    end
  end
end
