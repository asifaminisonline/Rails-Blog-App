require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', photo: 'https://t3.ftcdn.net/jpg/02/47/40/98/360_F_247409832_pPugfgU5cKLsrH5OCJRMn5JTcy2L1Rrg.jpg', bio: 'Anything', posts_counter: 5) }

  before { subject.save }

  it 'validates presence of name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'validates that posts_counter is an integer' do
    subject.posts_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'validates posts_counter greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#recent_posts' do
    before do
      6.times do |p|
        Post.create(title: "Post #{p}", text: "Text #{p}", comments_counter: 10, author_id: subject.id,
                    likes_counter: 10)
      end
    end

    it 'returns the three most recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.order(created_at: :asc).limit(3))
    end
  end
end
