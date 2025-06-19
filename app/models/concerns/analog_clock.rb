module AnalogClock
  BASE_HAND_DEGREE = 90.0
  def analog_angles
      [next_minute_angle, next_hour_angle]
  end

  def next_minute_angle
    @next_minute_angle ||= (next_time.min * 6) + (next_time.sec * 0.1) + BASE_HAND_DEGREE
  end

  def next_hour_angle
    @next_hour_angle ||= (next_time.hour % 12 * 30) + (next_time.min * 0.5) + BASE_HAND_DEGREE
  end
end
