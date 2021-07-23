class Artist < ApplicationRecord
  has_many :releases, dependent: :destroy
  has_many :albums, through: :releases

  include PgSearch::Model
  acts_as_favoritable
  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  pg_search_scope :search_by_id,
    against: :spotify_id,
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def fetch_releases
    latest_release_date = albums.any? ? albums.max_by(&:release_date).release_date : Date.today.prev_year
    # TODO: do we want to add 'appears_on' back in?
    # get all albums for an artist
    albums = RSpotify::Artist.find(spotify_id).albums(limit: 50, album_type: 'album,single')
    # TODO: remove market validation -- the feed constroller should choose market based on user location
    albums.select! { |album| album.available_markets.include?("AU") }
    # only select albums where we actually know the release day
    albums.select! { |album| album.release_date_precision == "day" }
    # only select albums that have been released since the last album stored in the DB
    albums.select! { |album| Date.parse(album.release_date) > latest_release_date }
    return albums
  end
end
