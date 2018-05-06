require 'application_system_test_case'

class UserFlowsTest < ApplicationSystemTestCase
  setup :setup_omniauth, :setup_auth_hash

  test 'log in with facebook and subscribe to calendar' do
    visit root_path

    click_button I18n.t(:login)

    assert_selector '#subscribe-button'

    click_button I18n.t(:subscribe)
  end
end
