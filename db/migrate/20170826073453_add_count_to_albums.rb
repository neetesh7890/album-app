class AddCountToAlbums < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :count, :integer
  end
end
