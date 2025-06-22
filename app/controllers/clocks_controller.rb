class ClocksController < ApplicationController
  include PatternAssignable

  def index
    margin = 3
    @now = Time.now
    factory = ClocksFactory.new(margin, pattern(@now), @now, start)
    @clocks = factory.create
    @cols = factory.matrix_width
  end

  private

  def start
    nil
  end
end
