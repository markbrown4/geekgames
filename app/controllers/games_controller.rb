class GamesController < ApplicationController

  before_filter :authenticate_user!
  before_filter do
    @menu = 'games'
  end

  # GET games/
  def index
    @rounds = current_user.rounds.today
  end
  
  # GET games/start
  def start
    logger.debug Time.now()
    @round = current_user.rounds.create()
    redirect_to :action => :play
  end

  # GET games/play
  def play
    @round = current_user.current_round
    if @round.incomplete
      @score = @round.current_score
      @game = @score.game
    else
      redirect_to :action => :index
    end
  end
  
  # POST games/submit
  def submit
    @round = current_user.current_round
    if @round.present?
      score = BigDecimal(params[:score])
      if @round.save_score(score)
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