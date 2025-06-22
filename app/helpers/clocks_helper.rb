module ClocksHelper
  def interval
    30000
  end

  def adjust_interval(now)
    now_min = now.sec > 30 ? now.sec - 30 : now.sec # 1..29
    (30 - now_min) * 1000 - millisecond
  end

  def reset_interval?(now)
    !(now.sec == 0 || now.sec == 30)
  end

  private

  def millisecond
    @millisecond ||= Time.now.strftime("%L").to_i
  end
end
