class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def create
  end
end
