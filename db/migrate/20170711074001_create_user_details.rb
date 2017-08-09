class CreateUserDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :user_details do |t|
      t.text :address
      t.string :city
      t.integer :pincode
      t.integer :phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
