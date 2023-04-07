class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_posts_likes_counter

  private

  def update_posts_likes_counter
    author.increment!(:posts_likes_counter)
  end
