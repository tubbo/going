Koala.configure do |config|
  facebook = Rails.application.credentials.facebook

  config.access_token = facebook[:access_token]
  config.app_access_token = facebook[:app_access_token]
  config.app_id = facebook[:app_id]
  config.app_secret = facebook[:app_secret]
end
