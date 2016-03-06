module UsersHelper
  def add_facebook_info_to_session(user)
    flash[:provider] = user.provider
    flash[:uid] = user.uid
    flash[:email] = user.email
    flash[:image_url] = user.image_url
    flash[:full_name] = user.full_name
    flash[:first_name] = user.first_name
    flash[:oauth_token] = user.oauth_token
    flash[:oauth_expires_at] = user.oauth_expires_at
  end

  def construct_user(params)
    User.new(
      provider: flash[:provider],
      uid: flash[:uid],
      image_url: flash[:image_url],
      email: flash[:email],
      full_name: flash[:full_name],
      oauth_token: flash[:oauth_token],
      oauth_expires_at: flash[:oauth_expires_at],
      phone: params[:phone],
      password: params[:password])
  end
end
