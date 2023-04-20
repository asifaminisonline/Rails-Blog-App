require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do
    first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/phot
        os/F_-0BxGuVvo', bio: 'Full-Stack Developer', posts_counter: 0)
    first_post = Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id,
                             comments_counter: 0, likes_counter: 0)
    first_comment = Comment.create(text: 'This is my first comment', author_id: first_user.id, post_id: first_post.id)

    first_comment.save

    it 'is not valid without a text' do
      first_comment.text = nil
      expect(first_comment).to_not be_valid
    end

    it 'posts comments count should be 0' do
      expect(first_post.comments_counter).to eq 0
    end
  end
  describe '#update_comments_counter' do
    it 'should update the posts comments counter' do
      first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Full-Stack Developer', posts_counter: 0)
      # rubocop:disable Lint/UselessAssignment
      first_post = Post.create(title: 'First Post', text: 'This is my first post', author: first_user,
                               comments_counter: 0, likes_counter: 0)
      first_comment = Comment.create(post: first_post, author: first_user, text: 'This is my first comment')
      # rubocop:enable Lint/UselessAssignment
      expect(first_post.comments_counter).to eq 1
    end
  end
end
