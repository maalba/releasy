class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Access and modify user's music library
    user_country = spotify_user.user_country
    user_following = spotify_user.following # Returns array of artists
    redirect_to artists_path
  end
end
