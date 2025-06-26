module Clock
  class Basic < ::ClockObject
    include AnalogClock
    include TimeBasedMovement

    VIEW_TYPE = :basic

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

    def view_type
      VIEW_TYPE
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
        time_based_target_angles(now.sec, next_analog_angles, pattern)
      end
    end
  end
end
