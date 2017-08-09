class AddPhoneToUserDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :user_details, :phone, :integer, :limit=>8
  end
end
