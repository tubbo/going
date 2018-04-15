require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @calendar = Calendar.new(@user.token)
    @facebook_event = {
      name: 'Event Name',
      description: 'Description of the event',
      place: {
        name: 'TBA',
        location: {
          street: '123 Fake Street',
        }
      },
      start_time: 1.hour.from_now,
      end_time: 2.hours.from_now,
      id: 12345
    }
    graph = mock('Koala::Facebook::API')
    graph.stubs(:get_connections).with('me', Calendar::EVENTS_QUERY).returns([@facebook_event])
    @calendar.stubs(:graph).returns(graph)
  end

  test 'find events from facebook' do
    refute_empty @calendar.events
    event = @calendar.events.first

    assert_equal @facebook_event[:name], event.summary
    assert_equal @facebook_event[:description], event.description
    assert_equal 'TBA 123 Fake Street', event.location
    assert_equal @facebook_event[:start_time], event.dtstart
    assert_equal @facebook_event[:end_time], event.dtend
    assert_equal "https://facebook.com/events/#{@facebook_event[:id]}", event.url.to_s
  end

  test 'convert to ical format' do
    refute_empty @calendar.to_ical
    assert_includes @calendar.to_ical, 'BEGIN:VCALENDAR'
    assert_includes @calendar.to_ical, 'VERSION:2.0'
    assert_includes @calendar.to_ical, 'BEGIN:VEVENT'
    assert_includes @calendar.to_ical, "SUMMARY:#{@facebook_event[:name]}"
  end
end
