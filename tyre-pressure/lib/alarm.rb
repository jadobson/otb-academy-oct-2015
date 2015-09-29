class Alarm
  def initialize(sensor, notifier)
  	@sensor, @notifier = sensor, notifier
  end

	def check
  	if in_range?(@sensor.sample_pressure)
  		@notifier.normal_range
  	else
  		@notifier.out_of_bounds
  	end
  end

  private

  def in_range?(pressure)
  	(17.5..21).include?(pressure)
  end
end
