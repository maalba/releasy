class Album < ApplicationRecord
  has_many :releases
  has_many :artists, through: :releases
end
