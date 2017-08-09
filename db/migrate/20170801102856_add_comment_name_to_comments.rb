class AddCommentNameToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :comment_name, :string
  end
end
