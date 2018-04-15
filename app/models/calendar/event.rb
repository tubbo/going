class Calendar
  class Event < Icalendar::Event
    def self.from_facebook(facebook_event)
      new do |event|
        event.name = facebook_event[:name]
        event.summary = facebook_event[:description]
        event.location = facebook_event[:place]
        event.dtstart = facebook_event[:start_time]
        event.dtend = facebook_event[:end_time]
        event.url = "https://facebook.com/events/#{facebook_event[:id]}"
      end
    end
  end
end
