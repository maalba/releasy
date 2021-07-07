namespace :artist do
  desc "Get newest releases for all followed artists"
  task get_new_releases: :environment do
    artists = Artist.all
    puts "Enqueuing update of #{artists.size} artists..."
    artists.each do |artist|
      GetNewReleasesJob.perform_later(artist)
    end
  end
  # rake task will return when all jobs are _enqueued_ (not done).
end
