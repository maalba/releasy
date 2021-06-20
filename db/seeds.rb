# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "authenticating spotify credentials..."
RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])

puts "cleaning out existing data..."
Artist.destroy_all
Album.destroy_all
Favorite.destroy_all

puts "Creating 20 new hip hop artists and grabbing releases from the last 5 months..."
20.times do
  artist = Faker::Music::Hiphop.artist
  artists = RSpotify::Artist.search(artist)
  chosen = artists.first
  name = chosen.name
  spotify_id = chosen.id
  image_url = chosen.images ? chosen.images.first["url"] : nil
  new_artist = Artist.create!(name: name, spotify_id: spotify_id, image_url: image_url)
  FetchRecentAlbumsJob.perform_later(new_artist)
end

puts "Creating 20 new bands and grabbing releases from the last 5 months..."

20.times do
  artist = Faker::Music.band
  artists = RSpotify::Artist.search(artist)
  chosen = artists.first
  name = chosen.name
  spotify_id = chosen.id
  image_url = chosen.images ? chosen.images.first["url"] : nil
  new_artist = Artist.create!(name: name, spotify_id: spotify_id, image_url: image_url)
  FetchRecentAlbumsJob.perform_later(new_artist)
end

puts "finished seeding!"
