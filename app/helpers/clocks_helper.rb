module ClocksHelper
  def interval
    990
  end

  def adjust_interval
    millisecond - 1000.abs
  end

  def reset_interval?
    (100..900).cover? millisecond
  end

  private

  def millisecond
    @millisecond ||= Time.now.strftime('%L').to_i
  end
end
