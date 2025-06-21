class ClocksController < ApplicationController
  def index
    margin = 2
    factory = ClocksFactory.new(margin, pattern, start)
    @clocks = factory.create
    @cols = factory.matrix_width
  end

  private

  def start
    nil
  end

  def pattern
    params[:pattern] || "flat"
  end
end
