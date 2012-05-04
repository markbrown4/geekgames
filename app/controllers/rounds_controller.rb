class RoundsController < ApplicationController

  before_filter :authenticate_user!
  before_filter do
    @menu = 'rounds'
  end

  # GET rounds/start
  def start
    @round = current_user.rounds.create()
    redirect_to :controller => :rounds, :action => :play
  end

  # GET rounds
  def index
    @rounds = current_user.rounds.today
  end

  # GET rounds/play
  def play
    @round = current_user.current_round
    if @round.incomplete
      @score = @round.current_score
      @game = @score.game
    else
      redirect_to :action => :index
    end
  end
  
  # POST rounds/submit
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