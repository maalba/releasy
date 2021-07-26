class GetNewReleasesJob < ApplicationJob
  include Sidekiq::Throttled::Worker
  queue_as :default

  sidekiq_options :queue => :default

  sidekiq_throttle({
    # Allow maximum 10 concurrent jobs of this class at a time.
    # :concurrency => { :limit => 10 },
    # Allow maximum 1 job processed per second.
    :threshold => { :limit => 1, :period => 1.second }
  })

  def perform(artist)
    puts "Getting new releases for #{artist.name}..."
    # get date of newest release; if no albums in DB, use last year
    albums = artist.fetch_releases
    albums.each do |album|
      new_album = Album.create!(
        title: album.name,
        release_date: Date.parse(album.release_date),
        album_type: album.album_type,
        spotify_id: album.id,
        cover_url: album.images ? album.images.first["url"] : nil
      )
      Release.create!(artist: artist, album: new_album)
    end
  end

  rescue_from ActiveRecord::RecordNotUnique do |exception|
    message = "Album exists already"
    puts message
    logger.error message
  end
end
