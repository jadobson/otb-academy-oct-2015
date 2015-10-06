require 'shouty'
RSpec.describe Network do
  it "broadcast messages to all subscribers within the range of 50m" do
    network = Network.new

    lucy = double("lucy", :location => [53.393655, -2.184552])
    pam = double("pam", :location => [53.393588, -2.184922])
    fred = double("fred", :location => [53.401036, -2.188575])

    network.subscribe(lucy)
    network.subscribe(pam)
    network.subscribe(fred)

    message = "Free Toast!"
    location = [53.393655, -2.184552]

    expect(lucy).to receive(:hear).with(message)
    expect(pam).to receive(:hear).with(message)
    expect(fred).not_to receive(:hear).with(message)

    network.broadcast(message, location)
  end

  it "can work out the difference between two subscibers" do
    network = Network.new

    lucy = double("lucy", :location => [53.393655, -2.184552])
    fred = double("fred", :location => [53.401036, -2.188575])

    network.distance(lucy.location, fred.location)
  end
end
