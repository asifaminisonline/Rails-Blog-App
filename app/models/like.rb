class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_create :update_likes_counter

  private

  def update_likes_counter
    post.update(LikesCounter: Like.where(post_id).count)
  end
end
