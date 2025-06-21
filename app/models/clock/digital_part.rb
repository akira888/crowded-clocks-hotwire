module Clock
  class DigitalPart < ::ClockObject
    include AnalogClock
    include TimeBasedMovement
    attr_reader :group

    def initialize(now, position, pattern, group, start = nil)
      super(now, position, pattern, start)
      @group = group
    end

    def big_hand_angle
      angles = target_angles
      "#{angles[0]}deg"
    end

    def small_hand_angle
      angles = target_angles
      "#{angles[1]}deg"
    end

    private

    def target_angles
      @target_angles ||= begin
        # 現在時刻のデジタル表示の角度
        current_angles = current_digital_angles

        # 次の時刻のデジタル表示の角度
        next_angles = next_digital_angles

        # 秒数に応じた針の動きを計算
        time_based_angles(current_angles, next_angles)
      end
    end

    def current_digital_angles
      angle_keyword = DigitalPartsMap.by_number(current_digital_number)[position.to_i(16)].to_s
      return analog_angles if Angle.not_parts?(angle_keyword)

      Angle.fixed_angles(angle_keyword)
    end

    def next_digital_angles
      angle_keyword = DigitalPartsMap.by_number(digital_number)[position.to_i(16)].to_s
      return analog_angles if Angle.not_parts?(angle_keyword)

      Angle.fixed_angles(angle_keyword)
    end

    def current_digital_number
      now.strftime("%H%M")[group].to_i
    end

    def digital_number
      next_time.strftime("%H%M")[group].to_i
    end
  end
end
