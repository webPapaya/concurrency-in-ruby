require 'thread'
require 'net/http'
require 'benchmark'

class Future
  def self.call(&block)
    Future.new block
  end

  def initialize(block)
    @thread = Thread.new { block.call }
  end

  def value
    @thread.value
  end

  def inspect
    @thread.status
  end
end




# def fetch_with_futures
#   images = Array.new(10) { |idx| "http://placehold.it/350x1#{idx*100}" }
#   futures = images.map do |image_url|
#     Future.call do
#       uri = URI(image_url)
#       Net::HTTP.get(uri)
#     end
#   end
#   futures.each(&:value)
# end
#
# def fetch_without_futures
#   images = Array.new(10) { |idx| "http://placehold.it/350x1#{idx*100}" }
#   images.each do |image_url|
#       uri = URI(image_url)
#       Net::HTTP.get(uri)
#   end
# end
#
# Benchmark.bm do |x|
#   x.report("futures: ") { fetch_with_futures }
#   x.report("without futures: ") { fetch_without_futures }
# end
