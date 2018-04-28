# Configure the Facebook API client for use with the 'Going' application
Koala.configure do |config|
  facebook = Rails.application.credentials.facebook

  config.app_id = facebook[:app_id]
  config.app_secret = facebook[:app_secret]
  config.api_version = 'v2.11'
end
