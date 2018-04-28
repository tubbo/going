module CalendarsHelper
  def calendar_url_for(user)
    "webcal://#{user.facebook_id}:#{user.token}@#{request.host}/calendar.ics"
  end
end
