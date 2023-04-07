class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  after_save :update_posts_counter

  def update_posts_counter
    author.update(post_counter: author.posts.count)
  end

  def recent_comments(num_comments = 5)
    comments.order(created_at: :desc).limit(num_comments)
  end
end
