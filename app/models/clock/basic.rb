module Clock
  class Basic < ::ClockObject
    include AnalogClock
    include TimeBasedMovement

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
        # 現在時刻の角度
        current_angles = [ current_minute_angle, current_hour_angle ]

        # 次の時刻の角度
        next_angles = analog_angles

        # 秒数に応じた針の動きを計算
        time_based_angles(current_angles, next_angles)
      end
    end

    def current_minute_angle
      (now.min * 6) + (now.sec * 0.1) + AnalogClock::BASE_HAND_DEGREE
    end

    def current_hour_angle
      (now.hour % 12 * 30) + (now.min * 0.5) + AnalogClock::BASE_HAND_DEGREE
    end
  end
end
