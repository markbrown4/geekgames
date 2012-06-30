class RoundsController < ApplicationController
  def win
    @deal = Deal.todays
    
    @round = current_user.best_round
    @rank = @round.rank.ordinalize
  end
end