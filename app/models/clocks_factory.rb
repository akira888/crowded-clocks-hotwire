class ClocksFactory
  def self.create(cols, rows, pattern, start = nil)
    sequence = 0
    rows.times.flat_map do
      cols.times.map do
        sequence.succ # 1 origin
        Clock.new(sequence, pattern, start)
      end
    end
  end
end
