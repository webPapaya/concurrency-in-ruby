require 'thread'
require 'thwait'
require 'singleton'

class ActorPool
  include Singleton

  def initialize
    @queue = Queue.new
  end

  def add(actor)
    @queue.push actor
  end

  def shutdown
    until @queue.length == 0 do
      actor = @queue.pop
      actor.shutdown
    end
  end
end

module Actor
  module ClassMethods
    def new(*)
      ActorProxy.new(super)
    end
  end

  class << self
    def included(klass)
      klass.extend(ClassMethods)
    end
  end

  class ActorProxy
    def initialize(target)
      ActorPool.instance.add self
      @target  = target
      @mailbox = Queue.new
      @mutex   = Mutex.new
      @threads = Queue.new
      @actor_async_proxy = ActorAsyncProxy.new self
    end

    def method_missing(method, *args)
      @target.public_send method, *args
    end

    def shutdown
      until @threads.length == 0 do
        @threads.pop.value
      end
    end

    def async
      @actor_async_proxy
    end

    def process_inbox
      @threads << Thread.new do
        method, args = @mailbox.pop
        process_message method, args
      end
    end

    def process_message(method, args)
      @mutex.synchronize do
        @target.public_send method, *args
      end
    end

    def deliver(method, *args)
      @mailbox.push [method, args]
      process_inbox
    end
  end

  class ActorAsyncProxy
    def initialize(actor_proxy)
      @actor_proxy = actor_proxy
    end

    def method_missing(method, *args)
      @actor_proxy.deliver method, *args
    end
  end
end