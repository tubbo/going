# API for showing the user's calendar with iCal
class CalendarsController < ApplicationController
  before_action :auth_user_by_token, if: :ical?
  before_action :require_user

  def show
    @calendar = current_user.calendar
  end

  private

  def auth_user_by_token
    authenticate_or_request_with_http_token(t(:name)) do |token, options|
      self.current_user = User.find_by(token: token)
    end
  end

  def require_user
    if current_user.blank?
      redirect_to root_path
      return
    end
  end

  def ical?
    request.format == :ical
  end
end
