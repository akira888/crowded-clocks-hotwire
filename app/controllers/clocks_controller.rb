class ClocksController < ApplicationController
  def index
    @cols = 2
    @rows = 2
    @clocks = ClocksFactory.create(@cols, @rows, pattern, start)
  end

  private

  def start
    nil
  end

  def pattern
    "flat"
  end
end

