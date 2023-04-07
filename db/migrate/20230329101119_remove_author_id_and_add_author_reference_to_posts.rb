class RemoveAuthorIdAndAddAuthorReferenceToPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :author_id
    add_reference :posts, :author, null: false, foreign_key: { to_table: :users }
  end
end
