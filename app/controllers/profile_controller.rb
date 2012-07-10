class ProfileController < ApplicationController

  before_filter :authenticate_user!
  
  def edit
  end
  
  def update
    if current_user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to games_path
    else
      flash[:error] = "Sorry, username is already taken"
      render :edit
    end
  end

end
