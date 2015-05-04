require 'eventmachine'
require 'em-http'
require 'thread'

module Reactor 
  class ImageDownloader
    include EM::Deferrable

    def initialize(caller, image_url)
      request = EM::HttpRequest.new(image_url).get
      request.callback do
        caller.image_downloaded
      end
    end
  end

  class ImageManager
    def initialize(images)
      @images = images
      @missing_images = Queue.new
      @images.each do |image_url|
        ImageDownloader.new self, image_url
      end
    end

    def image_downloaded
      @missing_images.push ''
      EM.stop if @missing_images.length == @images.length
    end
  end
end
