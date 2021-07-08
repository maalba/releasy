namespace :artist do
  desc "Get newest releases for all followed artists"
  task get_new_releases: :environment do
    artists = Artist.all
    puts "Checking new releases for #{artists.size} artists..."
    artists.each do |artist|
      GetNewReleasesJob.perform_later(artist)
    end
  end
end
