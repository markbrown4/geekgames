class RoundsController < ApplicationController
  before_filter do
    if !user_signed_in?
      redirect_to new_user_registration_path
    end
  end
  
  def win
    @deal = Deal.todays
    @round = current_user.best_round
    @rank = @round.rank.ordinalize
  end
end