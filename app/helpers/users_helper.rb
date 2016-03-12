module UsersHelper
  def add_facebook_info_to_session(user)
    session[:provider] = user.provider
    session[:uid] = user.uid
    session[:email] = user.email
    session[:image_url] = user.image_url
    session[:full_name] = user.full_name
    session[:first_name] = user.first_name
    session[:oauth_token] = user.oauth_token
    session[:oauth_expires_at] = user.oauth_expires_at
  end

  def construct_user(params)
    session[:provider] == 'facebook' ? construct_user_from_facebook(params) : User.new(params)
  end

  def construct_user_from_facebook(params)
    User.new(
    provider: session[:provider],
    uid: session[:uid],
    image_url: session[:image_url],
    email: session[:email],
    full_name: session[:full_name],
    oauth_token: session[:oauth_token],
    oauth_expires_at: session[:oauth_expires_at],
    phone: params[:phone],
    password: params[:password])
  end

  def remove_facebook_info_from_session
    session.delete(:provider)
    session.delete(:uid)
    session.delete(:email)
    session.delete(:image_url)
    session.delete(:full_name)
    session.delete(:first_name)
    session.delete(:oauth_token)
    session.delete(:oauth_expires_at)
  end
end
