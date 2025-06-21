class Angle
  UP = 90
  RIGHT = 180
  DOWN = 270
  LEFT = 0
  UP_RIGHT = 135
  UP_LEFT = 45
  DOWN_RIGHT = 225
  DOWN_LEFT = 315

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
