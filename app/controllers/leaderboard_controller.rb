class LeaderboardController < ApplicationController
  
  def index
    @menu = 'leaderboard'
    
    @leaders = Round.leaders
    @leaders_today = Round.leaders.today
    @country_scores = Round.top_three_countries
  end
  
end
