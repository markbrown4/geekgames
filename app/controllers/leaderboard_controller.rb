class LeaderboardController < ApplicationController
  
  def index
    @menu = 'leaderboard'
    
    @leaders = Round.leaders
    @leaders_today = Round.leaders.today
    @countries = ['Australia']
  end
  
end
