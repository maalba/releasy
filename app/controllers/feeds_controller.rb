class FeedsController < ApplicationController
  def show
    @followed_artists = current_user.all_favorited
    @album_releases = @followed_artists.map { |artist| artist.albums }.flatten
    @album_releases.sort_by! { |album| album.release_date }.reverse!
    @today = Date.today
  end
end
