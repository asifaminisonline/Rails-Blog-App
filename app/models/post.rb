class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
end
