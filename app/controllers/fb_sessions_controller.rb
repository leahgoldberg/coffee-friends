class FbSessionsController < ApplicationController
  include UserSessionsHelper
  include UsersHelper

  def new
    render 'user_sessions/fb_login'
  end

  def authenticate
    user = User.from_omniauth(auth_hash)
    add_facebook_info_to_session(user)
    render partial: 'user_sessions/fb_mid_login', locals: { user: user }, layout: false
  end

  def create
    user = construct_user(user_params)
    if user.save
      log_in_user(user)
      user.find_associated_coffees
      redirect_to root_path
    else
      flash[:errors] = user.errors.full_messages 
      render 'user_sessions/fb_login'
    end
  end

  def destroy
  end

  protected

  def auth_hash
    env['omniauth.auth']
  end

  def user_params
    params.require(:user).permit(:phone, :password)
  end

end
