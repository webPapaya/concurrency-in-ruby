# This is the demo file which should compare
# the Reactor Pattern, Futures and Actors.

require 'benchmark'
require 'net/http'

require_relative './../futures/futures'
require_relative './../reactor/reactor'
require_relative './../actor_based_model/main'

module FetchImages
  def self.images
    10.times.map { |idx| "http://placehold.it/350x1#{idx*100}" }
  end

  def self.iterative
    self.images.each do |image_url|
      uri = URI(image_url)
      Net::HTTP.get(uri)
    end
  end

  def self.futures
    futures = self.images.map do |image_url|
      Future.call do
        uri = URI(image_url)
        Net::HTTP.get(uri)
      end
    end
    futures.each(&:value)
  end

  def self.reactor
    EM.run do
      Reactor::ImageManager.new self.images
    end
  end

  def self.actor_based_model
    self.images.each do |image|
      downloader = ImageDownload.new image
      downloader.async.download
      downloader
    end
    Actor::ActorPool.instance.shutdown
  end
end

Benchmark.bm do |x|
  x.report("Iterative: ") { FetchImages.iterative }
  x.report("Futures:   ") { FetchImages.futures }
  x.report("Reactor:   ") { FetchImages.reactor }
  x.report("Actor:     ") { FetchImages.actor_based_model }
end

