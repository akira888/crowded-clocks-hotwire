class Clock
  include ActiveModel::API

  attr_reader :id

  STANDARD_HAND_DEGREE = 90.0

  def initialize(id, pattern,start=nil)
    @id = id
    @pattern = pattern
    @big_hand_angle = nil
    @small_hand_angle = nil
    @start = start
  end

  def big_hand_angle
    @big_hand_angle ||= "#{minute_degree}deg"
  end

  def small_hand_angle
    @small_hand_angle ||="#{hour_degree}deg"
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
end
