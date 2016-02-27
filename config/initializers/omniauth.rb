OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET'],
  :client_options => {
      :site => 'https://graph.facebook.com/v2.5',
      :authorize_url => "https://www.facebook.com/v2.5/dialog/oauth"
    },
    token_params: { parse: :json }
end
