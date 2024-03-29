class ArtistsController < ApplicationController
  after_action :authenticate_spotify, only: :index

  def index
    if params[:query].present?
      @query = params[:query]
      @artists = Artist.search_by_name(params[:query]).to_a
      spotify_artists = RSpotify::Artist.search(params[:query])
      spotify_artists.each do |artist|
        unless @artists.find { |a| a.spotify_id == artist.id }
          @artists << Artist.new(name: artist.name, spotify_id: artist.id, image_url: artist.images.first ? artist.images.first["url"] : "https://images.unsplash.com/photo-1614680376593-902f74cf0d41?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80")
        end
      end
    else
      @artists = Artist.all.sample(12)
      generate_recommendations unless current_user.all_favorited.empty?
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
    GetNewReleasesJob.perform_now(artist)
  end

  def add_from_spotify
    ids = params[:favorites]
    spotify_artists = RSpotify::Artist.find(ids)
    spotify_artists.each do |spotify_artist|
      artist = Artist.where(name: spotify_artist.name, spotify_id: spotify_artist.id, image_url: spotify_artist.images.first ? spotify_artist.images.first["url"] : "https://images.unsplash.com/photo-1614680376593-902f74cf0d41?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80").first_or_create
      # artist.save!
      current_user.favorite(artist) unless current_user.favorited?(artist)
      GetNewReleasesJob.perform_later(artist)
    end
    redirect_to dashboard_path, notice: "Artists added from Spotify"
  end

  private

  def generate_recommendations
    artist = current_user.all_favorited.sample
    id = artist.spotify_id
    spotify_artist = RSpotify::Artist.find(id)
    recommended_artists = spotify_artist.related_artists.sample(12)
    @recommendations = []
    recommended_artists.each do |artist|
      unless current_user.all_favorited.find { |favorited| favorited.spotify_id == artist.id }
        @recommendations << Artist.new(name: artist.name, spotify_id: artist.id, image_url: artist.images.first ? artist.images.first["url"] : "https://images.unsplash.com/photo-1614680376593-902f74cf0d41?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80")
      end
    end
  end

  def artist_params
    params.require(:artist).permit(:name, :spotify_id, :image_url)
  end

  def authenticate_spotify
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  end
end
