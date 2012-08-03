class GamesController < ApplicationController

  before_filter do
    if !user_signed_in?
      redirect_to new_user_registration_path
    else
      if Time.now > DateTime.new(2012, 8, 12, 21, 0) # 12 August 2012 at 9pm
        redirect_to finished_path
      end
      @round = current_user.current_round
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
      if @round.complete?
        User.increment_counter(:plays, current_user.id)
        flash[:success] = "Your score for that round was #{sprintf("%.2f", @round.total_score)}"
      end
      success()
    else
      error()
    end
  end
  
  def success
    redirect_url = flash[:success].present? ? win_path : games_path
    render :json => { that_makes_me: ':)', redirect_to: redirect_url  }.to_json, :status => 200
  end
  
  def invalid
    render :json => { :that_makes_me => ':)' }.to_json, :status => 400
  end
  
  def error
    render :json => { :that_makes_me => ':(' }.to_json, :status => 500
  end

end