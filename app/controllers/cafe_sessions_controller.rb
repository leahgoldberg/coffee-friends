class CafeSessionsController < ApplicationController
  def new
    @cafe = Cafe.new
  end

  def destroy
    log_out_cafe
    redirect_to root_path
  end

  private

  def cafe_session_params
    params.require(:cafe_session).permit(:email, :password)
  end

end
