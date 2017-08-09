class AddStatusToUserFriends < ActiveRecord::Migration[5.1]
  def change
    add_column :user_friends, :token, :string
    add_column :user_friends, :status, :string
  end
end
