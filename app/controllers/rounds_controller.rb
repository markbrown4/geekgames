class RoundsController < ApplicationController

  before_filter :authenticate_user!
  before_filter do
    @menu = 'rounds'
  end

  # GET rounds/start
  def start
    #@round = current_user.rounds.create()
    redirect_to :controller => :rounds, :action => :play
  end

  # GET rounds
  def index
    rounds = Round.find(:all, :conditions => ["user_id = ? and created_at > ?", current_user.id, Date.today])
  end

  # GET rounds/play
  def play
    @round = current_user.rounds.last;
    if @round.present?
      @score = Score.where("round_id = ? and game_id = ?", @round.id, @round.step).first
      @game = Game.find(@score.game_id)
    end
  end

end