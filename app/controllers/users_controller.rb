class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Set user's attributes based off spotify sign in
    current_user.spotify_id = spotify_user.id
    current_user.country = spotify_user.country
    current_user.save!

    # Get user's favorite artists from spotify
    @spotify_favorites = []
    @spotify_ids = []
    following_on_spotify = spotify_user.following(type: "artist", limit: 25)
    following_on_spotify.each do |artist|
      @spotify_ids << artist.id
      @spotify_favorites << Artist.new(name: artist.name, spotify_id: artist.id, image_url: artist.images.first ? artist.images.first["url"] : "https://images.unsplash.com/photo-1614680376593-902f74cf0d41?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80")
    end
    favorites_from_spotify = spotify_user.top_artists(limit: 25)
    favorites_from_spotify.each do |artist|
      @spotify_ids << artist.id
      @spotify_favorites << Artist.new(name: artist.name, spotify_id: artist.id, image_url: artist.images.first ? artist.images.first["url"] : "https://images.unsplash.com/photo-1614680376593-902f74cf0d41?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80")
    end
    @spotify_ids.uniq!
    @spotify_favorites.uniq! { |artist| artist.spotify_id }
  end

  def dismissed
    current_user.dismissed = true
    current_user.save!
    redirect_to artists_path
  end
end
