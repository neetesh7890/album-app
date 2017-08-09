class CreateUserFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :user_friends do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id
      t.timestamps
    end
  end
end
