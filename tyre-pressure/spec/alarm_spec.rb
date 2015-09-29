require 'alarm'
require 'sensor'

RSpec.describe "tyre pressure alarm" do
	let(:sensor) { Sensor.new }
  let(:alarm) { Alarm.new(sensor) }

  it "triggers the alarm if the tyre pressure is below the normal range (17.5)" do
  	allow(sensor).to receive(:sample_pressure) { 15.0 }
  	alarm.check

  	expect(alarm.on?).to eq(true)
  end

  it "triggers the alarm if the tyre pressure is above the normal range (21)" do
   	allow(sensor).to receive(:sample_pressure) { 25.0 }
  	alarm.check

  	expect(alarm.on?).to eq(true)
  end

  it "does not trigger the alarm if the tyre pressure is within the normal range (17.5-21)" do
   	allow(sensor).to receive(:sample_pressure) { 19.0 }
  	alarm.check

  	expect(alarm.on?).to eq(false)
  end

  it "does not trigger the alarm if the tyre pressure is on the edge of the allowed range" do
   	allow(sensor).to receive(:sample_pressure) { 19.0 }
  	alarm.check

  	expect(alarm.on?).to eq(false)  		
	end
end
