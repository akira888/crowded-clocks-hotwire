module PatternAssignable
  extend ActiveSupport::Concern

  def pattern(now)
    case (now.min % 4)
    when 0
        "horizontal"
    when 1
        "vertical"
    when 2
        "diagonal_right"
    when 3
        "diagonal_left"
    else
        "flat"
    end
  end
end
