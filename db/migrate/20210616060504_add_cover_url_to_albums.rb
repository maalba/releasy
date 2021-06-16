class AddCoverUrlToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :cover_url, :string
  end
end
