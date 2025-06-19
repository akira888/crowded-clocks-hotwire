module Clock
  class DigitalPart < ::ClockObject
    include AnalogClock
    attr_reader :group

    def initialize(now, position, pattern, start = nil, group = nil)
      super(now, position, pattern, start)
      @group = group
    end

    def big_hand_angle
      "#{target_angle.first}deg"
    end

    def small_hand_angle
      "#{target_angle.last}deg"
    end

    private

    def target_angle
      @target_angle ||= begin
        angle_keyword = DigitalPartsMap.by_number(digital_number)[position.to_i(16)].to_s
        return analog_angles if Angle.not_parts?(angle_keyword)

        Angle.fixed_angles(angle_keyword)
      end
    end

    def digital_number
      next_time.strftime("%H%M")[group].to_i
    end
  end
end
