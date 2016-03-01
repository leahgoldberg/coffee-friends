class FbSessionsController < ApplicationController
  include UserSessionsHelper

  def new
    render 'user_sessions/fb_login'
  end

  def create
    user = User.create_from_omniauth(auth_hash)
    log_in_user(user) if user.save
    render partial: 'user_sessions/fb_mid_login', locals: { user:user }, layout: false
  end

  def destroy
  end

  protected

  def auth_hash
    env['omniauth.auth']
  end

end
