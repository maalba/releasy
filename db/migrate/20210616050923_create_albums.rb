class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.date :release_date
      t.string :album_type
      t.string :spotify_id

      t.timestamps
    end
  end
end
