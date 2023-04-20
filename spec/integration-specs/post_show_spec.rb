# Add your code here
require 'rails_helper'
RSpec.describe 'Post show page', type: :feature do
  let!(:user) { User.create(name: 'John', bio: 'Dog lover', photo: 'john.jpg') }
  let!(:first_user) { User.first }
  let!(:users) { [first_user] }
  let!(:posts) { Post.all }
  first_user = User.create(name: 'Jerry', photo: 'https://images.unsplash.com/photo-1583864697784-a0efc8379f70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',
                           bio: 'Teacher from Mexico.', posts_counter: 0)
  first_post = Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id,
                           comments_counter: 0, likes_counter: 0)
  Post.create(title: 'Second Post', text: 'This is my second post', author_id: first_user.id,
              comments_counter: 0, likes_counter: 0)
  Post.create(title: 'Third Post', text: 'This is my third post', author_id: first_user.id,
              comments_counter: 0, likes_counter: 0)
  Post.create(title: 'Fourth Post', text: 'This is my fourth post', author_id: first_user.id,
              comments_counter: 0, likes_counter: 0)
  first_comment = Comment.create(post: first_post, author: first_user, text: 'This is my first comment')
  Like.create(post: first_post, author: first_user)
  before do
    visit user_post_path(user, first_post)
  end
  describe 'Page content' do
    it "should display post's title" do
      expect(page).to have_content(first_post.title)
    end
    it "should display user's name" do
      expect(page).to have_content(first_user.name)
    end
    it 'should display post body' do
      expect(page).to have_content(first_post.text)
    end
    it 'should display the username of each commentor' do
      expect(page).to have_content(first_comment.author.name)
    end
    it 'should display the comments each commentor left' do
      expect(page).to have_content(first_comment.text)
    end
    it 'should display comment counts for each post' do
      expect(page).to have_content('Comments: 1')
    end
    it 'should display total likes for a post' do
      expect(page).to have_content('Likes: 1')
    end
  end
end
