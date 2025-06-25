class ClocksFactory
  NORMAL_PARTS = "x".freeze
  NON_DIGITAL_PARTS = [ NORMAL_PARTS ].freeze

  attr_reader :margin, :pattern, :now

  def initialize(margin, pattern, now)
    @margin = margin
    @pattern = pattern
    @now = now
  end

  def create
    matrix.each_with_index.flat_map do |rows, row|
      rows.each_with_index.map do |char, col|
        if digital_parts?(char)
          group = digital_part_group(row, col)
          Clock::DigitalPart.new(now, char, pattern, group)
        else
          Clock::Basic.new(now, char, pattern)
        end
      end
    end
  end

  def matrix_width
    matrix.first.size
  end

  private

  def digital_parts?(char)
    !NON_DIGITAL_PARTS.include?(char)
  end

  def digital_part_group(row, col)
    return nil unless digital_parts?(matrix[row][col])

    # マージン部分を除いた相対位置を計算
    relative_col = col - margin

    # グループ番号（0-3）を計算
    group = relative_col / 4

    # 有効なグループ範囲内かチェック（0から3まで）
    return group if group.between?(0, 3) && (relative_col % 4) < 3

    nil
  end

  def matrix
    @matrix ||= begin
      total_width = margin * 2 + 3 * 4 + 3
      total_height = margin * 2 + 5

      grid = Array.new(total_height) { Array.new(total_width, NORMAL_PARTS) }

      4.times do |group|
        start_x = margin + group * 4
        start_y = margin

        5.times do |y|
          3.times do |x|
            position = y * 3 + x
            hex_value = position.to_s(16)
            grid[start_y + y][start_x + x] = hex_value
          end
        end
      end

      grid
    end
  end
end
