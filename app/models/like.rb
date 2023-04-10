class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_posts_like_counter

  private

  def update_posts_like_counter
    post.increment!(:likes_counter)
  end
end
