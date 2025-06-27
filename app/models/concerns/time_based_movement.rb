module TimeBasedMovement
  # 時間帯によって角度を決定するメソッド
  # 00~03秒: 現在の角度
  # 03~30秒: パターンに基づく方向へ移動
  # 30~33秒: パターンに基づく角度で固定
  # 33~00秒: 次の時刻の角度へ移動
  def time_based_angles(seconds, current_angles, next_angles, pattern_name)
    if seconds < 3
      current_angles
    elsif seconds < 30
      target_angles = pattern_angles(pattern_name)
      calculate_transition_angles(current_angles, target_angles, seconds - 3, 27)
    elsif seconds < 33
      pattern_angles(pattern_name)
    else
      calculate_transition_angles(pattern_angles(pattern_name), next_angles, seconds - 33, 27)
    end
  end

  def time_based_target_angles(seconds, next_angles, pattern_name)
    if seconds < 30
      pattern_angles(pattern_name)
    else
      next_angles
    end
  end

  private

  # パターンに基づいて目標角度を決定するメソッド
  def pattern_angles(pattern_name)
    case pattern_name
    when "horizontal"
      Angle.fixed_angles("left+right")
    when "vertical"
      Angle.fixed_angles("up+down")
    when "diagonal_right"
      Angle.fixed_angles("up_right+down_left")
    when "diagonal_left"
      Angle.fixed_angles("up_left+down_right")
    else
      # デフォルト（"flat"など）はleft_right
      Angle.fixed_angles("left+right")
    end
  end

  # 現在の角度から目標の角度へ徐々に移動する角度を計算
  def calculate_transition_angles(start_angles, target_angles, elapsed_time, total_time)
    return start_angles if start_angles.nil? || target_angles.nil?

    # 各針の角度を計算
    [
      calculate_angle_transition(start_angles[0], target_angles[0], elapsed_time, total_time),
      calculate_angle_transition(start_angles[1], target_angles[1], elapsed_time, total_time)
    ]
  end

  # 単一の針について、開始角度から目標角度への遷移を計算
  def calculate_angle_transition(start_angle, target_angle, elapsed_time, total_time)
    # 角度の差分を計算（時計回りか反時計回りかの最短経路を決定）
    diff = (target_angle - start_angle) % 360

    # 経過時間に基づいて現在の角度を計算
    progress = [ elapsed_time.to_f / total_time, 1.0 ].min
    (start_angle + diff * progress) % 360
  end
end
