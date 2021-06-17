class Release < ApplicationRecord
  belongs_to :artist, dependent: :destroy
  belongs_to :album, dependent: :destroy
end
