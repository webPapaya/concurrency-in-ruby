require_relative 'actor'
require 'net/http'

class ImageCollection
  include Actor

  def download(images)
    images = images[0]
    complete_handler = ImagesDownloaded.new
    images.each { |image| ImageDownload.new.deliver :download, complete_handler, image }
  end
end

class ImageDownload
  include Actor
  def download(image_url)
    puts ''
    puts "Downloading image #{image_url[1]}"

    uri = URI(image_url[1])
    Net::HTTP.get(uri)

    image_url[0].deliver :downloaded
    puts "Image Downloaded #{image_url[1]}"
    puts ''
  end
end

class ImagesDownloaded
  include Actor

  def initialize
    @downloaded = 0
  end

  def downloaded(*args)
    @downloaded += 1
    if @downloaded == 10
      puts ''
      puts 'All Images Downloaded'
      exit!
    end
  end
end

images = Array.new(10) { |idx| "http://placehold.it/350x1#{idx*100}" }
ImageCollection.new.deliver :download, images

sleep