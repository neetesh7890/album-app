class AddStatusEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :status_email, :boolean
  end
end
