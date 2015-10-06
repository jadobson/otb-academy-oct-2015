require 'shouty'

Given(/^the following subscribers:$/) do |table|
  @network = Network.new
  @subscribers = Hash.new
  table.hashes.each do |hash|
    p hash
    @subscribers[hash['name']] = Person.new(@network)
    @subscribers[hash['name']].move_to(hash['location'])
  end
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
