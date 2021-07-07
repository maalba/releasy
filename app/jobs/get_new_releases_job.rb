class GetNewReleasesJob < ApplicationJob
  queue_as :default

  def perform(artist)
    puts "Getting new releases for #{artist.name}..."
  end
end
