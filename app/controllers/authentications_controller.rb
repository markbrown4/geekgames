class AuthenticationsController < ApplicationController
  def create
    if authentication.present?
      flash[:notice] = "Ah, it's you.  How have you been?"
      sign_in_and_redirect authentication.user
    elsif user_signed_in?
      current_user.apply_authentication(omniauth) and current_user.save
      flash[:notice] = "Your account has been linked"
      redirect_to request.env['omniauth.origin'] || edit_user_path(current_user)
    else
      user = new_user_with_authentication

      if user.save
        session[:after_email_return_to] = session[:user_return_to] if user.email.blank?
        sign_in_and_redirect user
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    authentication.destroy
    redirect_to profile_path
  end

  private

  def authentication
    @authentication ||= if params[:id]
      current_user.authentications.find(params[:id])
    else
      Authentication.find_by_provider_and_uid(
        omniauth['provider'],
        omniauth['uid'].to_s
      )
    end
  end

  def omniauth
    request.env['omniauth.auth']
  end

  def auth_params
    request.env['omniauth.params'] || {}
  end

  def new_user_with_authentication
    user = User.new.tap { |user| user.apply_authentication omniauth }

    return user unless user.email.present?

    existing_user = User.find_by_email(user.email)
    if existing_user.present?
      flash[:notice] = "Your #{omniauth['provider'].titleize} account is now linked"
      existing_user.tap { |u| u.apply_authentication omniauth }
    else
      user
    end
  end

end
