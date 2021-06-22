class FetchRecentAlbumsJob < ApplicationJob
  queue_as :default

  def perform(artist)
    albums = RSpotify::Artist.find(artist.spotify_id).albums(limit: 50, album_type: 'album,single,appears_on')
    albums.select! { |album| album.available_markets.include?("US") }
    filtered_albums = albums.select do |album|
      (album.release_date_precision == "day" ? Date.parse(album.release_date)  : Date.today << 6) > (Date.today << 5) && album.album_type =~ /(album|single)/
    end
    recent_albums = []
    filtered_albums.each do |album|
      album_title = album.name
      album_release_date = album.release_date_precision == "day" ? Date.parse(album.release_date)  : nil
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
end
