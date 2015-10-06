require 'shouty'

describe Person do
  let(:network) { double.as_null_object }
  it "subscribe to the network when created" do
    expect(network).to receive(:subscribe).with(an_instance_of(Person))
    Person.new(network)
  end

  it "broadasts shouts using the network" do
    sean = Person.new(network)
    message = "Free Bagels!"
    location = [53.393655, -2.184552]
    sean.move_to(location)

    expect(network).to receive(:broadcast).with(message, location)

    sean.shout(message)
  end

  it "records messages heard" do
    lucy = Person.new(network)
    message = "Free Bagels!"
    lucy.move_to([53.393655, -2.184555])
    lucy.hear(message)

    expect(lucy.messages_heard).to include(message)
  end
end
