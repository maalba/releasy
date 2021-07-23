namespace :album do
  desc "remove duplicate albums from the DB"
  task remove_duplicates: :environment do
    albums = Album.all.group_by { |album| album.spotify_id }
    albums.values.each do |duplicates|
      first_one = duplicates.shift
      duplicates.each { |double| double.destroy }
    end
  end
end
