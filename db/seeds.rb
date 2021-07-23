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

puts "removing and creating test user"
User.find_by(email: 'bungizzle@mail.com').destroy unless User.find_by(email: 'bungizzle@mail.com') == nil
user = User.create(email: 'bungizzle@mail.com', password: "secret")


puts "adding artists"
artist_names = [ 'Tyler the Creator', 'Unknown Mortal Orchestra', 'Stimulator Jones', 'Japanese Breakfast']

artist_names.each do |artist_name|
  artists = RSpotify::Artist.search(artist_name)
  chosen = artists.first
  name = chosen.name
  spotify_id = chosen.id
  image_url = chosen.images ? chosen.images.first["url"] : nil
  new_artist = Artist.create!(name: name, spotify_id: spotify_id, image_url: image_url)
  user.favorite(new_artist)
  GetNewReleasesJob.perform_later(new_artist)
end

puts "finished seeding!"
