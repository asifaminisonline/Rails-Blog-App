class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  validates :text, presence: true

  after_create :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
