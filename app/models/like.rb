class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_posts_like_counter

  private
  after_create :update_likes_counter
  after_destroy :update_likes_counter

  def update_posts_like_counter
    post.increment!(:likes_counter)
  end
end
