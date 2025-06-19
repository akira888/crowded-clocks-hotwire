module Clock
  class Basic < ::ClockObject
    include AnalogClock

    def big_hand_angle
      @big_hand_angle ||= "#{next_minute_angle}deg"
    end

    def small_hand_angle
      @small_hand_angle ||="#{next_hour_angle}deg"
    end
  end
end
