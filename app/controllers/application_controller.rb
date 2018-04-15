class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
  end

  def current_user=(user)
    session[:user_id] = user&.id
    @current_user = user
  end
end
