class Angle
  UP = 0
  RIGHT = 90
  DOWN = 180
  LEFT = 270
  UP_RIGHT = 45
  UP_LEFT = 315
  DOWN_RIGHT = 135
  DOWN_LEFT = 225

  KNOWN_KEYWORD = %w[up down left right up_right up_left down_right down_left].freeze
  DELIMITER = "+".freeze

  NOT_PARTS = "not_parts".freeze

  class << self
    def fixed_angles(keyword)
      # デリミタを使用して方向キーワードをシンプルに分割
      # 例: "up+down" → ["up", "down"]
      angles = keyword.split(DELIMITER)
      return if angles.difference(KNOWN_KEYWORD).present?

      angles.map do |angle|
        const_name = "#{angle.upcase}".to_sym
        const_get(const_name)
      end
    end

    def not_parts?(keyword)
      NOT_PARTS == keyword
    end
  end
end
