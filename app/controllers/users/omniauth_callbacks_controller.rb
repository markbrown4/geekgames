require 'digest/md5'

class Users::OmniauthCallbacksController < ApplicationController
  def method_missing(method, *args)
    raise "Unknown Provider Method: #{method}" unless method.to_s.downcase =~ /(twitter|facebook)/

    omniauth = request.env['omniauth.auth']
    @user = User.includes(:authentications).merge(Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid'])).first

    if @user
      sign_in_and_redirect(:user, @user)

    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      redirect_to(redirect_location(:user, @user))
    else
      @user = User.new

      # randomize password for new users
      @user.password = (15..25).collect{(45..126).to_a[Kernel.rand(81)].chr}.join

      # add users email from the returned authentication hash
      @user.email = omniauth['user_info']['email']

      @user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      @user.save!
      sign_in_and_redirect(:user, @user)
    end
  end
end
