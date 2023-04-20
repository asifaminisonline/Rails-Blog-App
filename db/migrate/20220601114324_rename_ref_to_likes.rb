class RenameRefToLikes < ActiveRecord::Migration[7.0]
  def change
    rename_column :likes, :users_id, :author_id
  end
end
