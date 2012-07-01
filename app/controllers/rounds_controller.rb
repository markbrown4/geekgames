class RoundsController < ApplicationController
  before_filter do
    if !user_signed_in?
      redirect_to new_user_registration_path
    end
  end
  
  def win
    if params[:score].present?
      flash[:success] = "Your score for that round was #{sprintf("%.2f", params[:score])}"
    end
    @deal = Deal.todays
    @round = current_user.best_round
    @rank = @round.rank.ordinalize
  end
end