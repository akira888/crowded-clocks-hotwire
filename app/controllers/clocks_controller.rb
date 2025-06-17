class ClocksController < ApplicationController
  def index
    @cols = 20
    @rows = 7
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

