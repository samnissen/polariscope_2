class ActionSync
  def initialize
    @con = APIConnection.new
    @activities_path = "/api/v1/activities.json"
    @events_path = "/api/v1/java_script_event_types.json"
    @email = YAML.load(ERB.new(File.read(Rails.root.join('config', 'web_action_api.yml'))).result)[Rails.env]['email']
    @token = YAML.load(ERB.new(File.read(Rails.root.join('config', 'web_action_api.yml'))).result)[Rails.env]['token']
    @format = 'json'
  end

  def work
    begin
      get

      parse
    ensure
      queue_next
    end
  end

  def queue_next
    work
  end
  handle_asynchronously :queue_next, :queue => 'actions', :run_at => Proc.new { 4.hours.from_now }

  def parse
    parse_activities

    parse_events
  end

  def parse_events
    @events = JSON.parse(@jsevent_response.body)

    # Add any new, or modify as necessary
    @events.each do |event|
      JavaScriptEventType.find_or_initialize_by(name: event["name"]).tap do |j|
        j.save!
      end
    end

    # Remove any that don't exist in the source
    invalids = JavaScriptEventType.all.map { |olde|
      olde unless @events.map { |newe|
        true if (newe["name"] == olde.name)
      }.compact.first
    }.compact
    invalids.each do |inv|
      inv.destroy!
    end
  end

  def parse_activities
    @activities = JSON.parse(@activities_response.body)

    # Add any new, or modify as necessary
    @activities.each do |act|
      Activity.find_or_initialize_by(action_name: act["action_name"]).tap do |a|
        a.action_name       = act["action_name"]
        a.description       = act["description"]
        a.grouping          = act["grouping"]
        a.object_required   = act["object_required"]
        a.data_required     = act["data_required"]
        a.save!
      end
    end

    # Remove any that don't exist in the source
    invalids = Activity.all.map { |olda|
      olda unless @activities.map { |newa|
        true if (newa["action_name"] == olda.action_name)
      }.compact.first
    }.compact
    invalids.each do |inv|
      inv.destroy!
    end
  end

  def get
    @activities_response = @con.request(:get, @activities_path, {:user_email => @email, :user_token => @token, :format => @format })
    @jsevent_response = @con.request(:get, @events_path, {:user_email => @email, :user_token => @token, :format => @format })

    raise 'Unable to connect to Web Action API' unless @activities_response.code.to_i < 400
    raise 'Unable to connect to Web Action API' unless @jsevent_response.code.to_i < 400
  end
end
