namespace :artist do
  desc "Get newest releases for all followed artists"
  task get_new_releases: :environment do
    artists = Artist.all
    puts "Checking new releases for #{artists.size} artists..."
    artists.each do |artist|
      GetNewReleasesJob.perform_later(artist)
    end
  end

  desc "remove duplicate artists from the DB"
  task remove_duplicates: :environment do
    artists = Artist.all.group_by { |artist| artist.spotify_id }
    artists.values.each do |duplicates|
      first_one = duplicates.shift
      duplicates.each { |double| double.destroy }
    end
  end
end
