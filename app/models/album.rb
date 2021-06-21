class Album < ApplicationRecord
  has_many :releases, dependent: :destroy
  has_many :artists, through: :releases

  def start_time
    self.release_date
  end


end
