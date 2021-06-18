class ArtistsController < ApplicationController
  before_action :authenticate_spotify, only: :index

  def index
    if params[:query].present?
      @query = params[:query]
      @artists = Artist.search_by_name(params[:query])
      spotify_artists = RSpotify::Artist.search(params[:query])
      @spotify_artists = []
      spotify_artists.each do |artist|
        @spotify_artists << Artist.new(name: artist.name, spotify_id: artist.id, image_url: artist.images.first ? artist.images.first["url"] : "https://images.unsplash.com/photo-1614680376593-902f74cf0d41?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80")
      end
    else
      @artists = Artist.all
    end
    respond_to do |format|
      format.html
      format.json { render json: { artists: @artists } }
    end
  end

  def create
  end

  def toggle_follow
    @artist = Artist.find(params[:id])
    current_user.favorited?(@artist) ? current_user.unfavorite(@artist) : current_user.favorite(@artist)
  end

  def new_follow
    artist = Artist.new(artist_params)
    artist.save!
    current_user.favorite(artist)
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :spotify_id, :image_url)
  end

  def authenticate_spotify
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  end


end
