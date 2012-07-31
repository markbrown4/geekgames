class RoundsController < ApplicationController
  before_filter do
    if !user_signed_in?
      redirect_to new_user_registration_path
    end
  end
  
  def win
    @deal = Deal.current
    @rank = current_user.rank.ordinalize
  end
end