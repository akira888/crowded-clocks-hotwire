class ClockObject
  include ActiveModel::API

  attr_reader :now, :position, :pattern, :start

  def initialize(now, position, pattern, start = nil)
    @now = now
    @position = position
    @pattern = pattern
    @big_hand_angle = nil
    @small_hand_angle = nil
    @start = start
  end

  def big_hand_angle
    raise ::NotImplementedError
  end

  def small_hand_angle
    raise ::NotImplementedError
  end

  def big_hand_destination_angle
    raise ::NotImplementedError
  end

  def small_hand_destination_angle
    raise ::NotImplementedError
  end

  private

  def next_time
    # １分進める（針の移動先のベースとなる）
    @next_time ||= now.advance(minutes: 1)
  end
end
