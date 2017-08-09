class AddCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :count, :integer
  end
end
