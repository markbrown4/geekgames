class GamesController < ApplicationController

  before_filter :authenticate_user!
  before_filter do
    @menu = 'games'
  end

  # GET games/
  def index
    @round = current_user.current_round
    if @round.present?
      @game = Game.find(@round.step)
    else
      render :inline => 'Sorry you cant compete now', :status => 200
    end
  end
  
  # POST games/submit
  def submit
    @round = current_user.current_round
    if @round.present?
      if @round.proccess_score(params[:data])
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