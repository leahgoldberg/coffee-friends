class UsersController < ApplicationController
  include UsersHelper

  before_action :authorize_user, only: [:show]

  def new
    if current_user
      redirect_to cafes_path
    elsif current_cafe
      redirect_to cafes_profile_path  
    else
      remove_facebook_info_from_session
      @user = User.new
    end
  end

  def authenticate
    @user = User.from_omniauth(auth_hash)
    add_facebook_info_to_session(@user)
    render partial: 'users/fb_mid_login', locals: { user: @user }, layout: false
  end

  def create
    @user = construct_user(user_params)
    if @user.save
      remove_facebook_info_from_session
      log_in_user(@user)
      @user.find_associated_coffees
      if @user.source=='facebook'
        render js: "window.location = '#{cafes_path}'"
      else
        redirect_to cafes_path
      end
    else
      flash[:errors] = @user.errors.full_messages
      if @user.source=='facebook'
        render partial: 'users/fb_mid_login', locals: { user: @user }, layout: false
      else
        render 'new'
      end
    end
  end

  def show
    @user = current_user
    @given_coffees = @user.given_coffees
    @received_coffees = @user.received_coffees
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:user]
      @user.update_attributes(user_params.merge(params[:user]))
    else
      flash[:error] = ["Something went wrong! Your picture was not uploaded"]
    end
    render :show
  end

  protected

  def auth_hash
    env['omniauth.auth']
  end

  private

  def authorize_user
    redirect_to root_url unless current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone, :picture, :source)
  end
end
