require 'test_helper'

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  delegate :encode_credentials, to: ActionController::HttpAuthentication::Token

  setup do
    @user = users(:one)
  end

  test 'redirect to login page when not authenticated' do
    get calendar_path

    assert_redirected_to root_path
  end

  test 'show button when authenticated' do
    log_in_with_facebook
    get calendar_path

    assert_response :success
  end

  test 'download user calendar' do
    VCR.use_cassette :facebook_events do
      @user.update!(facebook_access_token: 'EAACuX4ZA8sRkBAIYB405JpljA4P5gY1oxmLl86CFZAOy2ZBz6zRxagKgLbwIYF0vo7IWZCtAPtMTPCt9ZC287kdhUzgXPc9xvL3GPIxQlfxPth0YxGNQL7Ggs7FfgmlhwYnXw3z1ykc3ZBfwmWZBZBqVhJlR3AZAEcQYlqnJ8oJr1kq4nWYSnJy5ZCzHiLZCUXxse1o5HAcvH4RpwZDZD')
      get calendar_path(format: 'ical'), headers: {
        'Authorization' => encode_credentials(@user.token)
      }

      assert_response :success
    end
  end
end
