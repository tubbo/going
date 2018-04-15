class Calendar
  delegate :to_ical, to: :@calendar

  def initialize(user)
    @user = user
    @calendar = Icalendar::Calendar.new
    @graph = Koala::Facebook::API.new(@user.token)
  end

  def self.find(user)
    new(user).tap(&:build)
  end

  def events
    @graph.get_connections('me', 'events').map do |facebook_event|
      Event.from_facebook(facebook_event)
    end
  end

  private

  def build
    events.each do |event|
      @calendar.add_event(event)
    end
  end
end
