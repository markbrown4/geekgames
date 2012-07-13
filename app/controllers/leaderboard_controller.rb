class LeaderboardController < ApplicationController
  
  def index
    @leaders = Round.leaders
    @country_scores = Round.top_three_countries
  end
  
end
