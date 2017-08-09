class RemovePhoneFromUserDetails < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_details, :phone, :integer
  end
end
