class DashboardsController < ApplicationController
  def show
    if params[:query].present?
      @followed_artists = Artist.search_by_name(params[:query]).select { |artist| current_user.favorited?(artist) }
      @query = params[:query]
    else
      @followed_artists = current_user.all_favorited
    end
  end
end
