class Album < ApplicationRecord
  has_many :releases, dependent: :destroy
  has_many :artists, through: :releases
end
