class ClocksController < ApplicationController
  def index
    @cols = 10
    @big_hand_deg = "#{90}deg"
    @small_hand_deg = "#{270}deg"
  end
end
