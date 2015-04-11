require_relative 'actor'
require 'net/http'

class ImageCollection
  def self.download(images)
    images.each {|image| ImageDownload.new.deliver :download, image}
  end
end

class ImageDownload
  include Actor
  def download(image_url)
    puts ''
    puts "Downloading image #{image_url}"

    uri = URI(image_url[0])
    Net::HTTP.get(uri)

    puts "Image Downloaded #{image_url}"
    puts ''
  end
end


images = Array.new(10) { |idx| "http://placehold.it/350x1#{idx*10}" }
ImageCollection.download images
sleep 20

