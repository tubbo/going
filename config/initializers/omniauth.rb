# Log messages to the Rails logger
OmniAuth.config.logger = Rails.logger

# Set up the OmniAuth middleware to authenticate with Facebook
Rails.application.config.middleware.use OmniAuth::Builder do
  credentials = Rails.application.credentials.facebook
  provider :facebook, credentials[:app_id], credentials[:app_secret], scope: 'user,events'
end
