# API for showing the user's calendar with iCal
class CalendarsController < ApplicationController
  before_action :basic_auth_user, if: :ical?
  before_action :require_user

  def show
    @calendar = current_user.calendar
    expires_in 30.minutes, public: true
  end

  private

  def basic_auth_user
    authenticate_or_request_with_http_basic t(:name) do |id, token|
      self.current_user = User.find_by(facebook_id: id, token: token)
      logger.info "Authenticated user #{current_user.email} from basic auth"
    end
  end

  def require_user
    if current_user.blank?
      redirect_to root_path
      return
    end
  end

  def ical?
    request.format == :ics
  end
end
