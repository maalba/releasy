# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do
  puts "Finding artist from faker..."
  artist = Faker::Music.band
  puts "Searching spotify..."
  artists = RSpotify::Artist.search(artist)
  puts "getting spotify info..."
  chosen = artists.first
  name = chosen.name
  spotify_id = chosen.id
  image_url = chosen.images ? chosen.images.first["url"] : nil
  puts "seeding artist..."
  Artist.create!(name: name, spotify_id: spotify_id, image_url: image_url)
end

20.times do
  puts "Finding artist from faker..."
  artist = Faker::Music::Hiphop.artist
  puts "Searching spotify..."
  artists = RSpotify::Artist.search(artist)
  puts "getting spotify info..."
  chosen = artists.first
  name = chosen.name
  spotify_id = chosen.id
  image_url = chosen.images ? chosen.images.first["url"] : nil
  puts "seeding artist..."
  Artist.create!(name: name, spotify_id: spotify_id, image_url: image_url)
end

puts "finished seeding!"
