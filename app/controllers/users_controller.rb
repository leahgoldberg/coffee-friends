class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in_user(user)
      redirect_to root_path, notice: "Account Has Created!!"
    else
      flash[:registration_error] = user.errors.full_messages
      redirect_to register_path
    end
  end

  def show
    @user = User.find_by(id: params[:format])
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :phone)
  end
end
