class Angle
  UP = 90
  RIGHT = 180
  DOWN = 270
  LEFT = 0

  KNOWN_KEYWORD = %w[up down left right].freeze

  NOT_PARTS = "not_parts".freeze

  class << self
    def fixed_angles(keyword)
      angles = keyword.split("_", 2)
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
