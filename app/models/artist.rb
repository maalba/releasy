class Artist < ApplicationRecord
  include PgSearch::Model
  acts_as_favoritable
  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
