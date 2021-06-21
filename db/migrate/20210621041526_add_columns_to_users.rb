class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :spotify_id, :string
    add_column :users, :country, :string
  end
end
