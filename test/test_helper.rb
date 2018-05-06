ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
  config.ignore_hosts '127.0.0.1', 'localhost'
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module FacebookAuth
  extend ActiveSupport::Concern

  included do
    setup :setup_omniauth
  end

  def log_in_with_facebook
    setup_auth_hash
    get create_user_path(provider: 'facebook')
    assert_response :redirect
  end

  def setup_omniauth
    OmniAuth.config.test_mode = true
  end

  def setup_auth_hash
    name = 'User Name'
    email = 'test@example.com'
    token = SecureRandom.hex
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: 1234567890,
      info: {
        name: name,
        email: email,
      },
      credentials: {
        access_token: token
      }
    )
  end
end

class ActionDispatch::IntegrationTest
  include FacebookAuth
end
