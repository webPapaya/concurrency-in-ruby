require 'celluloid'
require 'net/http'

module CelluloidDownloader
  class ImageDownload
    include Celluloid
    def initialize(image_url)
      @image_url = URI(image_url)
    end

    def download
      Net::HTTP.get(@image_url)
    end
  end
end
