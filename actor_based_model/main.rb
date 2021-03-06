require_relative 'actor'
require 'net/http'
require 'pry'

class ImageDownload
  include Actor
  def initialize(image_url)
    @image_url = URI(image_url)
  end

  def download
    Net::HTTP.get @image_url
  end
end
