class Admin::UsersController < Admin::ApplicationController
  
  expose(:users) { User.search(params[:search], params[:page]) }
  expose(:user)
  
  def update
    if user.save
      flash[:success] = "User updated"
      redirect_to edit_admin_user_path(user)
    else
      render :edit
    end
  end
  
end