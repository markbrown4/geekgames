class RoundsController < ApplicationController
  def summary
    @round = current_user.rounds.last
  end
end