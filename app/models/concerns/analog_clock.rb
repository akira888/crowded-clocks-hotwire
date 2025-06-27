module AnalogClock
  def current_analog_angles
      [ minute_angle(now), hour_angle(now) ]
  end

  def next_analog_angles
    [ minute_angle(next_time), hour_angle(next_time) ]
  end

  def minute_angle(time)
    (time.min * 6) + (time.sec * 0.1)
  end

  def hour_angle(time)
    (time.hour % 12 * 30) + (time.min * 0.5)
  end
end
