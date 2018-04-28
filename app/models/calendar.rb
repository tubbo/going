# frozen_string_literal: true

# Facebook events calendar for a given User.
class Calendar
  EVENTS_QUERY = 'events?fields=name,description,start_time,end_time,place{name,location{city,country,state,street,zip}}'
  delegate :to_ical, to: :@calendar

  def initialize(access_token)
    @token = access_token
    @calendar = Icalendar::Calendar.new
  end

  def events
    @events ||= graph.get_connections('me', EVENTS_QUERY).map do |facebook_event|
      create_event_from(facebook_event)
    end
  end

  def to_ical
    events
    Rails.logger.info 'Generating calendar from Facebook events'
    @calendar.to_ical
  end

  private

  def graph
    @graph ||= Koala::Facebook::API.new(@token)
  end

  def create_event_from(facebook_event)
    facebook_event.deep_symbolize_keys!
    location = []
    location << facebook_event[:place][:name]
    if facebook_event[:place][:location].present?
      location += facebook_event[:place][:location].except(:latitude, :longitude).values
    end

    @calendar.event do |event|
      event.summary = facebook_event[:name]
      event.description = facebook_event[:description]
      event.location = location.join(' ').strip
      event.dtstart = facebook_event[:start_time]&.to_datetime
      event.dtend = facebook_event[:end_time]&.to_datetime
      event.url = "https://facebook.com/events/#{facebook_event[:id]}"
    end
  end
end
