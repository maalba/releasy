class Artist < ApplicationRecord
  has_many :releases
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
end
