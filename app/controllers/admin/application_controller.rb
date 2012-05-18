class Admin::ApplicationController < ApplicationController
  
  layout 'admin'
  before_filter :authenticate_user!
  
  before_filter do
    unless current_user.admin?
      flash[:alert] = 'You do not have access.'
      redirect_to '/'
    end
  end
  
end
