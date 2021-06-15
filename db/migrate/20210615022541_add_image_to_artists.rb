class AddImageToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :image_url, :string
  end
end
