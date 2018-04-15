Rails.application.config.middleware.use OmniAuth::Builder do
  credentials = Rails.application.credentials.facebook
  if credentials.present?
    provider(
      :facebook,
      credentials[:app_id],
      credentials[:app_secret],
      scope: 'user,events'
    )
  end
end
