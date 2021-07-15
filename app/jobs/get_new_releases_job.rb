class GetNewReleasesJob < ApplicationJob
  queue_as :default

  def perform(artist)
    puts "Getting new releases for #{artist.name}..."
    # get date of newest release; if no albums in DB, use last year
    latest_release_date = artist.albums.any? ? artist.albums.max_by(&:release_date).release_date : Date.today.prev_year
    # TODO - add 'appears_on' back in after demo
    albums = RSpotify::Artist.find(artist.spotify_id).albums(limit: 50, album_type: 'album,single')
    # TODO - choose available market based on user location
    albums.select! { |album| album.available_markets.include?("AU") }
    albums.select! { |album| album.release_date_precision == "day" }
    albums.select! { |album| Date.parse(album.release_date) > latest_release_date }
    recent_albums = []
    albums.each do |album|
      album_title = album.name
      album_release_date = Date.parse(album.release_date)
      album_type = album.album_type
      album_spotify_id = album.id
      album_cover_url = album.images ? album.images.first["url"] : nil
      new_album = Album.create!(title: album_title, release_date: album_release_date, album_type: album_type, spotify_id: album_spotify_id, cover_url: album_cover_url)
      recent_albums << new_album
    end
    recent_albums.each do |album|
      release = Release.new
      release.artist = artist
      release.album = album
      release.save!
    end
  end

  rescue_from ActiveRecord::RecordNotUnique do |exception|
    message = "Album exists already"
    puts message
    logger.error message
  end
end
