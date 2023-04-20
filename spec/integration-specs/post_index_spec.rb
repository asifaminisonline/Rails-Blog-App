require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  let!(:first_user) { User.first }
  let!(:users) { [first_user] }
  let!(:posts) { Post.all }
  # Create a test user with associated posts and comments to be displayed on the show page
  first_user = User.create(name: 'Jerry', photo: 'https://unsplash.com/photos/iFgRcqHznqg',
                           bio: 'Teacher from Mexico.', posts_counter: 0)

  first_post = Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id,
                           comments_counter: 0, likes_counter: 0)
  second_post = Post.create(title: 'Second Post', text: 'This is my second post', author_id: first_user.id,
                            comments_counter: 0, likes_counter: 0)
  Post.create(title: 'Third Post', text: 'This is my third post', author_id: first_user.id,
              comments_counter: 0, likes_counter: 0)
  Post.create(title: 'Fourth Post', text: 'This is my fourth post', author_id: first_user.id,
              comments_counter: 0, likes_counter: 0)

  first_comment = Comment.create(post: first_post, author: first_user, text: 'This is my first comment')
  Like.create(post: first_post, author: first_user)
  before do
    visit user_posts_path(first_user.id)
  end
  describe 'Page content' do
    it "should display user's profile picture" do
      expect(page).to have_css("img[src='#{first_user.photo}']")
    end
    it "should display user's name" do
      expect(page).to have_content(first_user.name)
    end
    it 'can see the number of posts the user has written' do
      expect(page).to have_text("Number of posts: #{first_user.posts.count}")
    end
    it 'should display all post titles' do
      expect(page).to have_content(first_post.title)
      expect(page).to have_content(second_post.title)
    end
    it "should display some of posts' content" do
      expect(page).to have_content(first_post.text[0..200])
      expect(page).to have_content(second_post.text[0..200])
    end
    it 'should display recent comments on a post' do
      expect(page).to have_content(first_comment.text)
    end
    it 'should display comment counts for each post' do
      expect(page).to have_content("Comments: #{first_post.comments_counter}")
      expect(page).to have_content("Comments: #{second_post.comments_counter}")
    end
    it 'should display like counts for each post' do
      expect(page).to have_content("Likes: #{first_post.likes_counter}")
    end
    it 'sould go to the post show page when clicking on the post title' do
      click_link(first_post.title)
      expect(page).to have_current_path(user_post_path(first_user.id, first_post.id))
    end
    it 'should have a button for pagination' do
      expect(page).to have_button('More Posts')
    end
  end
end
