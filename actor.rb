require 'thread'
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
      @target  = target
      @mailbox = Queue.new
      @mutex   = Mutex.new

      @running = true

      @thread = Thread.new do
        process_inbox
      end
    end

    def process_inbox
      while @running
        method, args = @mailbox.pop
        process_message method, args
      end
    end

    def process_message(method, args)
      @mutex.synchronize do
        @target.public_send method, args
      end
    end

    def deliver(method, *args)
        @mailbox.push [method, args]
    end
  end
end