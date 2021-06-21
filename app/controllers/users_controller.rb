class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Set user's attributes based off spotify sign in
    current_user.spotify_id = spotify_user.id
    current_user.country = spotify_user.country
    current_user.save!

    # Get user's favorite artists from spotify
    @following_on_spotify = spotify_user.following(type: "artist", limit: 50)
    @favorites_from_spotify = spotify_user.top_artists(limit: 50)
  end
end
