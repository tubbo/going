require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup :setup_auth_hash

  test 'facebook authentication' do
    get create_user_path(provider: 'facebook')

    assert_redirected_to calendar_path
  end
end
