class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_user_post_count

  validates :Title, presence: true, length: { maximum: 250 }
  validates :LikesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :CommentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_user_post_count
    author.update(posts_count: Post.where(author_id).count)
  end

  private

  def get_recent_comments(limit_count = 5)
    comments.order(created_at: :desc).limit(limit_count)
  end
end
