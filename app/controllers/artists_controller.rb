class ArtistsController < ApplicationController
  def index
    if params[:query].present?
      @artists = Artist.search_by_name(params[:query])
    else
      @artists = Artist.all
    end
  end

  def create
  end
end
