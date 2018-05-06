class UsersController < ApplicationController
  def new
    if current_user.present?
      redirect_to calendar_path
      return
    end

    expires_in 15.minutes, public: true
  end

  def create
    self.current_user = User.from_omniauth(auth_hash)
    redirect_to calendar_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
