class DashboardsController < ApplicationController
  def show
    @followed_artists = current_user.all_favorited
  end
end
