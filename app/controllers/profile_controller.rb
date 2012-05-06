class ProfileController < ApplicationController

  before_filter do
    @menu = 'profile'
  end
  
  def edit
  end
  
  def update
    current_user.update_attributes(params[:user])
    render :edit
  end

end
