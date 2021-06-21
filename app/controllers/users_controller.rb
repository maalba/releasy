class UsersController < ApplicationController
  before_action :authenticate_spotify, only: :spotify 
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @country = spotify_user.country
  end

  private

  def authenticate_spotify
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  end
end
