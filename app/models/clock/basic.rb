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

    def big_hand_fixed_angle
      sec = now.sec < 30 ? 30 : 0
      "#{target_angles_at(sec)[0]}deg"
    end

    def small_hand_fixed_angle
      sec = now.sec < 30 ? 30 : 0
      "#{target_angles_at(sec)[1]}deg"
    end

    private

    def target_angles
      @target_angles ||= begin
        # 現在時刻の角度
        current_angles = [ current_minute_angle, current_hour_angle ]

        # 次の時刻の角度
        next_angles = analog_angles

        # 秒数に応じた針の動きを計算
        time_based_angles(current_angles, next_angles, pattern)
      end
    end

    def target_angles_at(sec)
      current_angles = [ current_minute_angle, current_hour_angle ]
      next_angles = analog_angles
      # 指定秒での針の動きを計算
      now_for_sec = now.change(sec: sec)
      # TimeBasedMovementのtime_based_anglesを一時的にnow_for_secで呼ぶ
      # self.nowを一時的に差し替え
      old_now = @now
      @now = now_for_sec
      result = time_based_angles(current_angles, next_angles, pattern)
      @now = old_now
      result
    end

    def current_minute_angle
      (now.min * 6) + (now.sec * 0.1) + AnalogClock::BASE_HAND_DEGREE
    end

    def current_hour_angle
      (now.hour % 12 * 30) + (now.min * 0.5) + AnalogClock::BASE_HAND_DEGREE
    end
  end
end
