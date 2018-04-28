require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create user from omniauth hash' do
    name = 'User Name'
    email = 'test@example.com'
    token = SecureRandom.hex
    user = User.from_omniauth(
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

    assert user.valid?, user.errors.full_messages.to_sentence
    assert user.persisted?, 'Could not save User to the database'
  end

  test 'user has a calendar' do
    user = users(:one)
    assert_kind_of Calendar, user.calendar
  end

  test 'user generates a token when one does not exist' do
    user = users(:one)
    user.update!(token: nil)

    assert user.token.present?
  end
end
