require 'shouty'

Given(/^(\w+\b) is (\d+)m from (\w+)$/) do |person, distance, person_two|
  @network = Network.new
  @subscribers = Hash.new { |hash, key| hash[key] = Person.new(@network) }
  @subscribers[person].move_to(distance)
end

When(/^(\w+\b) shouts "([^"]*)"$/) do |person, message|
  @seans_message = message
  @subscribers[person].shout(message)
end

Then(/^(\w+\b) hears (\w+)'s message$/) do |person, person_two|
  expect(@subscribers[person].messages_heard).to include(@seans_message)
end

Then(/^(\w+\b) does not hear (\w+)'s message$/) do |person, person_two|
  expect(@subscribers[person].messages_heard).not_to include(@seans_message)
end
