require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    let(:author) { User.create(name: 'me', photo: 'photo', bio: 'bio', posts_counter: 5) }
    let(:post) do
      Post.create(author_id: author.id, title: 'Post', text: 'Text', likes_counter: 5, comments_counter: 5)
    end
    subject { Comment.new(author_id: author.id, post_id: post.id, text: 'Hi') }

    before do
      subject.save
      post.reload # Reload post to make sure it has the correct comments_counter value
    end

    it 'should have a valid author id' do
      subject.author_id = nil
      expect(subject).to_not be_valid
    end

    it 'should have a valid post id' do
      subject.post_id = nil
      expect(subject).to_not be_valid
    end

    it 'should increment comments_counter' do
      expect { Comment.create(author_id: author.id, post_id: post.id, text: 'Hello') }.to change {
                                                                                            post.reload.comments_counter
                                                                                          }.by(1)
    end
  end
end
