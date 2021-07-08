class ChangeSpotifyIdUniqueAlbums < ActiveRecord::Migration[6.0]
  def change
    add_index :albums, :spotify_id, unique: true
  end
end
