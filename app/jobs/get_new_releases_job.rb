class GetNewReleasesJob < ApplicationJob
  queue_as :default

  def perform(artist)
    puts "Getting new releases for #{artist.name}..."
    # get date of newest release; if no albums in DB, use last year
    latest_release_date = artist.albums.any? ? artist.albums.max_by(&:release_date).release_date : Date.today.prev_year
    albums = artist.fetch_releases(latest_release_date)
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
