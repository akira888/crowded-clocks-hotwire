class DigitalPartsMap
  # 方向キーワードを定数として定義
  NOT_PARTS = "not_parts".freeze

  # 複合キーワード
  UP_DOWN = "up+down".freeze
  DOWN_UP = "down+up".freeze
  LEFT_RIGHT = "left+right".freeze
  RIGHT_LEFT = "right+left".freeze
  UP_LEFT = "up+left".freeze
  UP_RIGHT = "up+right".freeze
  DOWN_LEFT = "down+left".freeze
  DOWN_RIGHT = "down+right".freeze
  RIGHT_RIGHT = "right+right".freeze
  LEFT_LEFT = "left+left".freeze
  UP_UP = "up+up".freeze
  DOWN_DOWN = "down+down".freeze

  def self.by_number(number)
    case number
    when 0
        [
          DOWN_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          UP_RIGHT,
          LEFT_RIGHT,
          UP_LEFT
        ]
    when 1
        [
          NOT_PARTS,
          NOT_PARTS,
          DOWN_DOWN,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          UP_UP
        ]
    when 2
        [
          RIGHT_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          DOWN_RIGHT,
          LEFT_RIGHT,
          UP_LEFT,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          UP_RIGHT,
          LEFT_RIGHT,
          LEFT_LEFT
        ]
    when 3
        [
          RIGHT_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          RIGHT_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          RIGHT_RIGHT,
          LEFT_RIGHT,
          UP_LEFT
        ]
    when 4
        [
          DOWN_DOWN,
          NOT_PARTS,
          DOWN_DOWN,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          UP_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          UP_UP
        ]
    when 5
        [
          DOWN_RIGHT,
          LEFT_RIGHT,
          LEFT_LEFT,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          UP_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          RIGHT_RIGHT,
          LEFT_RIGHT,
          UP_LEFT
        ]
    when 6
        [
          DOWN_RIGHT,
          LEFT_RIGHT,
          LEFT_LEFT,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          UP_RIGHT,
          LEFT_RIGHT,
          UP_LEFT
        ]
    when 7
        [
          RIGHT_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          NOT_PARTS,
          NOT_PARTS,
          UP_UP
        ]
    when 8
        [
          DOWN_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          UP_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          UP_RIGHT,
          LEFT_RIGHT,
          UP_LEFT
        ]
    when 9
        [
          DOWN_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          DOWN_UP,
          NOT_PARTS,
          DOWN_UP,
          UP_RIGHT,
          LEFT_RIGHT,
          DOWN_LEFT,
          NOT_PARTS,
          NOT_PARTS,
          DOWN_UP,
          RIGHT_RIGHT,
          LEFT_RIGHT,
          UP_LEFT
        ]
    else
        []
    end
  end
end
