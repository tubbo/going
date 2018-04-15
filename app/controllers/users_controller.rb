class UsersController < ApplicationController
  def new
    redirect_to calendar_path and return if current_user.present?
  end

  def create
    self.current_user = User.from_omniauth(**auth_hash)
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
