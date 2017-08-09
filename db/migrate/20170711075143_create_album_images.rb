class CreateAlbumImages < ActiveRecord::Migration[5.1]
  def change
    create_table :album_images do |t|
      t.references :album, foreign_key: true
      t.string :image_name

      t.timestamps
    end
  end
end
