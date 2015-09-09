class ActionSync
  def initialize
    @con = APIConnection.new
    @path = "/api/v1/activities.json"
    @email = YAML.load_file(Rails.root.join('config', 'web_action_api.yml'))[Rails.env]['email']
    @token = YAML.load_file(Rails.root.join('config', 'web_action_api.yml'))[Rails.env]['token']
    @format = 'json'
  end

  def work
    get

    parse

    queue_next
  end

  def queue_next
    work
  end
  handle_asynchronously :queue_next, :queue => 'actions', :run_at => Proc.new { 24.hours.from_now }

  def parse
    @activities = JSON.parse(@res.body)

    # Add any new, or modify as necessary
    @activities.each do |act|
      Activity.find_or_initialize_by(action_name: act["action_name"]).tap do |a|
        a.action_name  = act["action_name"]
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
    @res = @con.request(:get, @path, {:user_email => @email, :user_token => @token, :format => @format })

    raise 'Unable to connect to Web Action API' unless @res.code.to_i < 400
  end
end
