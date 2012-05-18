class Admin::PagesController < Admin::ApplicationController

  expose(:pages) { Page.all }
  expose(:page)
  
  def index
    render :edit
  end

  # def new
  #   render :edit
  # end

  # def create
  #   if page.save
  #     redirect_to edit_admin_page_path(page), :success => "Page created"
  #   else
  #     render :edit
  #   end
  # end

  def update
    if page.save
      flash[:success] = "Page updated"
      redirect_to edit_admin_page_path(page)
    else
      render :edit
    end
  end
  
end