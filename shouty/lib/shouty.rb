class Person
  attr_reader :location

  def initialize(network)
    @network = network
    @network.subscribe(self)
    @messages_heard = []
    @location = 0
  end

  def move_to(location)
    @location = location.to_i
  end

  def shout(message)
    @network.broadcast(message, @location)
    self
  end

  def hear(message)
    @messages_heard << message
  end

  def messages_heard
    @messages_heard
  end
end

class Network
  def initialize
    @subscribers = []
  end

  def subscribe(subscriber)
    @subscribers << subscriber
    self
  end

  def broadcast(message, location)
    subscribers_within_range(location).each { |subscriber| subscriber.hear(message) }
  end

  private

  def subscribers_within_range(location)
    @subscribers.find_all { |subscriber| (subscriber.location - location).abs <= range }
  end

  def range
    50
  end
end
