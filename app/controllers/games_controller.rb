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
    data = Base64.decode64(params[:data])
    if @round.process_score(data)
      success()
    else
      error()
    end
  end
  
  def success
    render :json => { :score => @round.total_score }.to_json
  end
  
  def invalid
    render :inline => ':P', :status => 400
  end
  
  def error
    render :inline => ':(', :status => 500
  end

end