class GamesController < ApplicationController

  before_filter do
    if !user_signed_in?
      redirect_to new_user_registration_path
    end
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
    # data = munge(params[:data], 5)
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
  
  
  
  private
  
  def munge(text, key)
    result = ""
    text.each_byte do |c|
      result += (key ^ c).chr;
    end
    result
  end

end