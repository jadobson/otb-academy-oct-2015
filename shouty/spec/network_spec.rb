require 'shouty'
RSpec.describe Network do
  it "broadcast messages to all subscribers within the range of 50m" do
    network = Network.new

    lucy = double("lucy", :location => 0)
    pam = double("pam", :location => 10)
    fred = double("fred", :location => 60)

    network.subscribe(lucy)
    network.subscribe(pam)
    network.subscribe(fred)

    message = "Free Toast!"
    location = 0

    expect(lucy).to receive(:hear).with(message)
    expect(pam).to receive(:hear).with(message)
    expect(fred).not_to receive(:hear).with(message)

    network.broadcast(message, location)
  end
end
