module Clock
  class DigitalPart < ::ClockObject
    include AnalogClock
    include TimeBasedMovement
    attr_reader :group

    def initialize(now, position, pattern, group)
      super(now, position, pattern)
      @group = group
    end

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
          current_angles,
          next_angles,
          pattern
        )
      end
    end

    def destination_angles
      @destination_angles ||= begin
        time_based_target_angles(now.sec, next_angles, pattern)
      end
    end

    def current_angles
      angle_keyword = DigitalPartsMap.by_number(digital_number(now))[position.to_i(16)].to_s
      return current_analog_angles if Angle.not_parts?(angle_keyword)

      Angle.fixed_angles(angle_keyword)
    end

    def next_angles
      angle_keyword = DigitalPartsMap.by_number(digital_number(next_time))[position.to_i(16)].to_s
      return next_analog_angles if Angle.not_parts?(angle_keyword)

      Angle.fixed_angles(angle_keyword)
    end

    def digital_number(time)
      time.strftime("%H%M")[group].to_i
    end
  end
end
