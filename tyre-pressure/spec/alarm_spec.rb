require 'alarm'
require 'sensor'
require 'blink_notifier'

RSpec.describe "tyre pressure alarm" do
	let(:sensor) { Sensor.new }
	let(:notifier) { BlinkNotifier.new }
  let(:alarm) { Alarm.new(sensor, notifier) }

  it "triggers the alarm if the tyre pressure is below the normal range (17.5)" do
  	allow(sensor).to receive(:sample_pressure) { 15.0 }
		expect(notifier).to receive(:out_of_bounds)
		alarm.check
  end

  it "triggers the alarm if the tyre pressure is above the normal range (21)" do
  	allow(sensor).to receive(:sample_pressure) { 25.0 }
		expect(notifier).to receive(:out_of_bounds)
		alarm.check
  end

  it "does not trigger the alarm if the tyre pressure is within the normal range (17.5-21)" do
  	allow(sensor).to receive(:sample_pressure) { 19.0 }
		expect(notifier).to receive(:normal_range)
		alarm.check
  end

  it "does not trigger the alarm if the tyre pressure is on the edge of the allowed range" do
  	allow(sensor).to receive(:sample_pressure) { 17.5 }
		expect(notifier).to receive(:normal_range)
		alarm.check		
	end
end
