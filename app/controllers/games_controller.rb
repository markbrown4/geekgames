class GamesController < ApplicationController

  before_filter do
    if !user_signed_in?
      redirect_to new_user_registration_path
    else
      @round = current_user.current_round
      unless @round.present?
        flash[:alert] = "Sorry, you can only compete 3 times a day, please try again tomorrow."
        redirect_to win_path
      end
    end
  end

  # GET games/
  def index
    @game = Game.find(@round.step)
  end
  
  # POST games/submit
  def submit
    # data = munge(params[:data], 5)
    if @round.proccess_score(params[:data])
      success()
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