class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', inverse_of: :author, dependent: :destroy
  has_many :likes, foreign_key: 'author_id', inverse_of: :author, dependent: :destroy
  has_many :comments, foreign_key: 'author_id', inverse_of: :author, dependent: :destroy

  # For the User model:Name must not be blank.
  validates :name, presence: true
  # PostsCounter must be an integer greater than or equal to zero.
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :asc).limit(3)
  end
end
