class ChangeSpotifyIdUniqueArtists < ActiveRecord::Migration[6.0]
  def change
    add_index :artists, :spotify_id, unique: true
  end
end
