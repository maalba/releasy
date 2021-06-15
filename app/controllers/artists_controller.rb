class ArtistsController < ApplicationController
  before_action :authenticate_user!, only: :toggle_follow

  def index
    if params[:query].present?
      @artists = Artist.search_by_name(params[:query])
    else
      @artists = Artist.all
    end
  end

  def create
  end

  def toggle_follow
    @artist = Artist.find(params[:id])
    current_user.favorited?(@artist) ? current_user.unfavorite(@artist) : current_user.favorite(@artist)
  end

end
