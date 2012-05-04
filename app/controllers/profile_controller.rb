class ProfileController < ApplicationController

  def edit
  end
  
  def update
    current_user.update_attributes(params[:user])
    render :edit
  end

end
