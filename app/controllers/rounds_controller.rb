class RoundsController < ApplicationController
  def summary
    @round = current_user.best_round
    @rank = @round.rank.ordinalize
  end
end