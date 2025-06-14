class ClocksController < ApplicationController
  STANDARD_HAND_DEGREE = 90.0
  def index
    @cols = 2
    @big_hand_deg = "#{minute_degree}deg"
    @small_hand_deg = "#{hour_degree}deg"
    @is_reset_interval = reset_interval?
  end

  private

  def minute_degree
    @minute_degree ||= (next_time.min * 6) + (next_time.sec * 0.1) + STANDARD_HAND_DEGREE
  end

  def hour_degree
    @hour_degree ||= (next_time.hour % 12 * 30) + (next_time.min * 0.5) + STANDARD_HAND_DEGREE
  end

  def next_time
    # １秒進める（つぎのポジションを返す）
    @next_time ||= Time.now.advance(seconds: 1)
  end

  def reset_interval?
    false
  end
end

