# Authentication and identification object for the application,
# authenticates with Facebook and pulls Facebook data with their given
# access token.
class User < ApplicationRecord
  before_validation :generate_token, unless: :token?

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true
  validates :facebook_access_token, presence: true
  validates :facebook_id, presence: true

  def self.from_omniauth(auth = {})
    auth.deep_symbolize_keys!
    params = auth[:info].slice(:name, :email)
    params[:facebook_access_token] = auth[:credentials][:token]

    find_or_initialize_by(facebook_id: auth[:uid]).tap do |user|
      user.update!(params.compact.to_h)
    end
  end

  def calendar
    Calendar.new(self)
  end

  private

  def generate_token
    self.token ||= SecureRandom.hex
  end
end
