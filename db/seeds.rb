# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "authenticating spotify credential..."
RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
puts "cleaning out existing data..."
Artist.delete_all
Album.delete_all

puts "Creating 20 new hip hop artists and one album for each..."

20.times do
  artist = Faker::Music::Hiphop.artist
  artists = RSpotify::Artist.search(artist)
  chosen = artists.first
  name = chosen.name
  spotify_id = chosen.id
  image_url = chosen.images ? chosen.images.first["url"] : nil
  new_artist = Artist.new(name: name, spotify_id: spotify_id, image_url: image_url)
  new_artist.save
  album = chosen.albums.first
  album_title = album.name
  album_release_date = album.release_date_precision == "day" ? Date.parse(album.release_date)  : nil
  album_type = album.type
  album_spotify_id = album.id
  album_cover_url = album.images ? album.images.first["url"] : nil
  new_album = Album.new(title: album_title, release_date: album_release_date, album_type: album_type, spotify_id: album_spotify_id, cover_url: album_cover_url)
  new_album.save
  release = Release.new()
  release.artist = new_artist
  release.album = new_album
  release.save
end

puts "Creating 20 new bands and one album for each..."

20.times do
  artist = Faker::Music.band
  artists = RSpotify::Artist.search(artist)
  chosen = artists.first
  name = chosen.name
  spotify_id = chosen.id
  image_url = chosen.images ? chosen.images.first["url"] : nil
  new_artist = Artist.new(name: name, spotify_id: spotify_id, image_url: image_url)
  new_artist.save
  album = chosen.albums.first
  album_title = album.name
  album_release_date = album.release_date_precision == "day" ? Date.parse(album.release_date)  : nil
  album_type = album.type
  album_spotify_id = album.id
  album_cover_url = album.images ? album.images.first["url"] : nil
  new_album = Album.new(title: album_title, release_date: album_release_date, album_type: album_type, spotify_id: album_spotify_id, cover_url: album_cover_url)
  new_album.save
  release = Release.new()
  release.artist = new_artist
  release.album = new_album
  release.save
end

puts "finished seeding!"
