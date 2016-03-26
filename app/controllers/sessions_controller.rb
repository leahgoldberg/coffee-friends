class SessionsController < ApplicationController

  def create
    if Cafe.find_by(email: session_params[:email_or_phone].downcase)
      @cafe = Cafe.find_by(email: session_params[:email_or_phone].downcase)
      if @cafe && @cafe.authenticate(session_params[:password])
        log_in_cafe(@cafe)
        redirect_to cafes_profile_path
      else
        flash[:cafe_error] = "Incorrect email or password"
        redirect_to root_path
      end


    else
      user = User.find_by(email: session_params[:email_or_phone].downcase)
      if user && user.authenticate(session_params[:password].downcase)
        log_in_user(user)
        redirect_to cafes_path
      else
        flash[:login_error] = "Incorrect email or password"
        redirect_to root_path
      end
    end
  end

  def destroy
    log_out_user
    log_out_cafe
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email_or_phone, :password)
  end
end
