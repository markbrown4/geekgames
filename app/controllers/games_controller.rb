class GamesController < ApplicationController

  before_filter :authenticate_user!
  before_filter do
    @menu = 'games'
  end

  # GET games/
  def index
    @round = current_user.current_round
    if !@round.incomplete
      @round = current_user.rounds.create()
    end
    @score = @round.current_score
    @game = @score.game
  end
  
  # POST games/submit
  def submit
    @round = current_user.current_round
    if @round.present?
      if @round.save_score(params[:score])
        success()
      else
        error()
      end
    else
      error()
    end
  end
  
  def success
    render :inline => ':)', :status => 200
  end
  
  def invalid
    render :inline => ':P', :status => 400
  end
  
  def error
    render :inline => ':(', :status => 500
  end

end