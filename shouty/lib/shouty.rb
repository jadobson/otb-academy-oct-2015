module Geo
  include Math

  RADIUS = 6371

  def distance(from, to)
    lat1, long1 = deg_2_rad *from
    lat2, long2 = deg_2_rad *to
    2 * RADIUS * asin(sqrt(sin((lat2-lat1)/2)**2 + cos(lat1) * cos(lat2) * sin((long2 - long1)/2)**2))
  end

  def deg_2_rad(lat, long)
    [lat * PI / 180, long * PI / 180]
  end
end

class Person
  attr_reader :location

  def initialize(network)
    @network = network
    @network.subscribe(self)
    @messages_heard = []
    @location = [0.0,0.0]
  end

  def move_to(location)
    @location = location
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
  include Geo

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
    @subscribers.find_all { |subscriber| distance(subscriber.location, location).abs <= range }
  end

  def range
    0.05
  end
end
