class ProfileController < ApplicationController

  before_filter do
    @menu = 'profile'
  end
  
  def edit
  end
  
  def update
    if current_user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to games_path
    else
      render :edit
    end
  end

end
