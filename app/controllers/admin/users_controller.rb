class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  end
  
  def edit
  end
  
  def update
    if @page.update_attributes(params[:page])
      redirect_to page_path(@page.stub)
    else
      render :edit
    end
  end
  
end