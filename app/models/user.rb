class User < ApplicationRecord
  def self.from_omniauth(provider: , uid: , info: {}, credentials: {}, extra: {})
    find_or_initialize_by(facebook_id: uid).tap do |user|
      user.name = info[:name]
      user.email = info[:email]
      user.token = credentials[:access_token]
      user.save!
    end
  end
end
