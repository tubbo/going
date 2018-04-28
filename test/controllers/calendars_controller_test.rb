require 'test_helper'

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  delegate :encode_credentials, to: ActionController::HttpAuthentication::Basic

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
      get calendar_path(format: :ics), headers: {
        'Authorization' => encode_credentials(@user.facebook_id, @user.token)
      }

      assert_response :success
    end
  end
end
