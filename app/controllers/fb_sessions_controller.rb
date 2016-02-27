class FbSessionsController < ApplicationController
  include UserSessionsHelper

  def new
    render 'user_sessions/fb_login'
  end

  def create
    user = user.create_from_omniauth(auth_hash)
    if user.save
      log_in_user
      redirect_to root_path
    else
      render 'user_sessions/fb_login'
    end
  end

  def destroy
  end

  protected

  def auth_hash
    env['omniauth.auth']
  end

end
