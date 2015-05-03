# This is a simple implementation of the a future

require 'thread'

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
