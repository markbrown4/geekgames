class RoundsController < ApplicationController
  def summary
    @deal = Deal.todays
    redirect_to home_path unless @deal.present?
    
    @round = current_user.best_round
    @rank = @round.rank.ordinalize
  end
end