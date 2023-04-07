require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = User.create(name: 'John Doe', photo: 'photo url', bio: 'Awesome bio', posts_counter: 0)
    @post = Post.create(Title: 'Awesome Post', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0)
  end

  describe 'update_post_comments_counter' do
    it 'should update the CommentsCounter attribute of the associated post' do
      expect(@post.CommentsCounter).to eq(0)
      Comment.create(author: @user, post: @post)
      expect(@post.CommentsCounter).to eq(1)
      Comment.create(author: @user, post: @post)
      expect(@post.CommentsCounter).to eq(2)
    end
  end

  it 'have correct user' do
    @comment = Comment.create(post: @post, author: @user)
    expect(@comment.author_id).to eq(@user.id)
  end
end
