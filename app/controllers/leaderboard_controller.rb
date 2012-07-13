class LeaderboardController < ApplicationController
  
  def index
    @leaders = User.top_ten
    @country_scores = Round.top_three_countries
  end
  
end
