# frozen_string_literal: true

# Facebook events calendar for a given User.
class Calendar
  # GraphQL query for event data executed within +Calendar#events+.
  EVENTS_QUERY = 'events?fields=name,description,start_time,end_time,place{name,location{city,country,state,street,zip}}'

  def initialize(user)
    @user = user
    @calendar = Icalendar::Calendar.new
  end

  # All events from the user's Facebook calendar converted into iCal events.
  #
  # @return [Array<Icalendar::Event>]
  def events
    @events ||= graph.get_connections('me', EVENTS_QUERY).map do |facebook_event|
      create_event_from(facebook_event)
    end
  end

  # The cache key for the calendar is based off of its given User's
  # cache key. There is a single calendar cache key per User.
  #
  # @return [String]
  def cache_key
    [@user.cache_key, :calendar].join('/')
  end

  # Based on the start time for the most recent event, the cache version
  # changes whenever events on a user's calendar changes, thus breaking
  # the cache and forcing a re-fetch of the data from Facebook.
  #
  # @return [Integer] Epoch time for the most recent event.
  def version
    return Time.now.to_i unless events.any?
    most_recent_event.dtstart.to_i
  end

  # The most recent event on the calendar.
  #
  # @return [Icalendar::Event]
  def most_recent_event
    recent_events.first
  end

  # Events on the calendar sorted by start time.
  #
  # @return [Array<Icalendar::Event>]
  def recent_events
    events.sort { |e1, e2| e1.dtstart <=> e2.dtstart }
  end

  # Render the calendar in +webcal://+.
  #
  # @return [String] iCal-formatted calendar of events.
  def to_ical
    events
    Rails.logger.info 'Generating calendar from Facebook events'
    @calendar.to_ical
  end

  private

  # Based on their Facebook access token, this method returns an
  # authenticated client that can retrieve the current User's data.
  #
  # @private
  # @return [Koala::Facebook::API] API client for the Facebook Graph.
  def graph
    @graph ||= Koala::Facebook::API.new(@user.facebook_access_token)
  end

  # Create a new +Icalendar::Event+ from Facebook event data.
  #
  # @private
  # @param [Hash] facebook_event - Data for a single Facebook event.
  # @return [Icalendar::Event]
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
