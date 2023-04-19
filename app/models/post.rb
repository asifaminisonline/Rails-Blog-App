class Post < ApplicationRecord
  attribute :comments_counter, :integer, default: 0
  attribute :likes_counter, :integer, default: 0
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_create :update_post_counter

  private

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
