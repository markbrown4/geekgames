class Admin::UsersController < Admin::ApplicationController
  
  expose(:user)
  
  def index
    @users = User.search(params[:search], params[:page])
  end
  
  def update
    if user.save
      flash[:success] = "User updated"
      redirect_to edit_admin_user_path(user)
    else
      render :edit
    end
  end
  
  def destroy
    user.destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_path
  end
  
end