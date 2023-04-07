require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = User.create(name: 'John Doe', photo: 'photo url', bio: 'Awesome bio', posts_counter: 0)
    @post = Post.create(Title: 'Awesome Post', Text: 'Post body', author: @user, CommentsCounter: 0, LikesCounter: 0)
  end

  describe 'update_post_likes_counter' do
    it 'should update post LikesCounter after creating a new Like' do
      expect(@post.LikesCounter).to eq(0)
      Like.create(author: @user, post: @post)
      expect(@post.reload.LikesCounter).to eq(1)
    end
  end
end
