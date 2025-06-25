class ClocksController < ApplicationController
  include PatternAssignable

  def index
    margin = 3
    @now = Time.now
    factory = ClocksFactory.new(margin, pattern(@now), @now)
    @clocks = factory.create
    @cols = factory.matrix_width
    @turbo_visit = turbo_visit?
  end

  private

  def turbo_visit?
    request.headers[:HTTP_TURBO_FRAME].present?
  end
end
