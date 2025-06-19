module PatternMakable
  def transit_pattern?(time)
    (5..30).cover?(time.sec)
  end
end
