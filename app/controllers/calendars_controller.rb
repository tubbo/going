class CalendarsController < ApplicationController
  before_action :http_basic_authenticate, if: :ical?
  before_action :authenticate!

  def show
    @calendar = Calendar.find(current_user)

    respond_to do |format|
      format.html # show.html.erb
      format.ical { render ical: @calendar.to_ical }
    end
  end

  private

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |token, options|
      self.current_user = User.find_by(api_key: token)
    end
  end

  def authenticate!
    redirect_to new_user_path and return if current_user.blank?
  end

  def ical?
    request.format == :ical
  end
end
