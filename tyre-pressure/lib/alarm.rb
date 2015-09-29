class Alarm
  def initialize(sensor)
  	@sensor = sensor
  end

  def on?
  	@alarm 
  end

	def check
  	@alarm = !in_range?(@sensor.sample_pressure)
  end

  private

  def in_range?(pressure)
  	(17.5..21).include?(pressure)
  end
end
