class FeedsController < ApplicationController
  def show
    @followed_artists = current_user.all_favorited
    @album_releases = @followed_artists.map { |artist| artist.release }
  end
end
