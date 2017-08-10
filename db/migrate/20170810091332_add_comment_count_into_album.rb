class AddCommentCountIntoAlbum < ActiveRecord::Migration[5.1]
  def self.up
    add_column :albums, :comment_count, :integer
  end

  def self.down
    remove_column :albums, :comment_count
  end
end
