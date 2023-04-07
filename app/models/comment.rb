class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_comments_counter
    post.increment!(:comments_counter)
  after_create :update_post_comments_counter

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
