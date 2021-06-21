class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Access and modify user's music library
    spotify_user.saved_tracks.size #=> 20
    redirect_to artists_path
  end
end
