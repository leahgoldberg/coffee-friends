class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if Cafe.find_by(email: user_session_params[:email].downcase)
      @cafe = Cafe.find_by(email: user_session_params[:email].downcase)
      if @cafe && @cafe.authenticate(user_session_params[:password])
        log_in_cafe(@cafe)
        redirect_to cafes_profile_path
      else
        flash[:cafe_error] = "Incorrect email or password"
        redirect_to root_path
      end      


    else
      user = User.find_by(email: user_session_params[:email].downcase)
      if user && user.authenticate(user_session_params[:password].downcase)
        log_in_user(user)
      else
        flash[:login_error] = "Incorrect email or password"
      end
      redirect_to root_url
    end
  end

  def destroy
    log_out_user
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
