require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Post 1', text: 'Text 1', comments_counter: 10, author_id: 1, likes_counter: 10) }
  before { subject.save }

  it 'validates presence of title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'validates title length less than 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'validates comments_counter as an integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'validates comments_counter greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'validates likes_counter as an integer' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'validates likes_counter greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#recent_comments' do
    before do
      10.times do |c|
        Comment.create(text: "Comment #{c}", post_id: subject.id, author_id: 1, created_at: Time.now + c)
      end
    end

    it 'should return the 5 most recent comments' do
      expect(subject.recent_comments).to eq(Comment.where(post_id: subject.id).order(created_at: :asc).limit(5))
    end
  end

  let(:user) { User.create(name: 'Jane', photo: 'https://t3.ftcdn.net/jpg/02/47/40/98/360_F_247409832_pPugfgU5cKLsrH5OCJRMn5JTcy2L1Rrg.jpg', bio: 'Anything', posts_counter: 0) }

  it "updates the author's posts counter after saving a new post" do
    expect do
      Post.create(title: 'Test Post', text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0, author_id: user.id)
    end.to(change { user.reload.posts_counter }.from(0).to(1))
  end
end
