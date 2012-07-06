class Admin::ErrorsController < Admin::ApplicationController
  
  def index
    @errors = ErrorLog.search(params[:search], params[:page])
  end
  
end