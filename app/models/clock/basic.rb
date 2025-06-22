module Clock
  class Basic < ::ClockObject
    include AnalogClock
    include TimeBasedMovement

    def big_hand_angle
      angles = hand_angles
      "#{angles[0]}deg"
    end

    def small_hand_angle
      angles = hand_angles
      "#{angles[1]}deg"
    end

    def big_hand_destination_angle
      "#{destination_angles[0]}deg"
    end

    def small_hand_destination_angle
      "#{destination_angles[1]}deg"
    end

    private

    def hand_angles
      @target_angles ||= begin
        time_based_angles(
          now.sec,
          current_analog_angles,
          next_analog_angles,
          pattern
        )
      end
    end

    def destination_angles
      @destination_angles ||= begin
        sec = now.sec < 30 ? 33 : 3
        time_based_target_angles(sec, next_analog_angles, pattern)
      end
    end
  end
end
