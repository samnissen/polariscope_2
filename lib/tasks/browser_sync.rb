class BrowserSync
  def initialize
    @con = APIConnection.new
    @path = "/api/v1/browser_types.json"
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
  handle_asynchronously :queue_next, :queue => 'browsers', :run_at => Proc.new { 2.hours.from_now }

  def parse
    @browser_types = JSON.parse(@res.body)

    # Add any new, or modify as necessary
    @browser_types.each do |act|
      BrowserType.find_or_initialize_by(key: act["key"]).tap do |a|
        a.name       = act["name"]
        a.key        = act["key"]
        a.archived   = false
        a.save!
      end
    end

    # Remove any that don't exist in the source
    invalids = BrowserType.all.map { |oldb|
      olda unless @browser_types.map { |newb|
        true if (newb["key"] == oldb.key)
      }.compact.first
    }.compact
    invalids.each do |inv|
      inv.archived = true
      inv.save!
    end
  end

  def get
    @res = @con.request(:get, @path, {:user_email => @email, :user_token => @token, :format => @format })

    raise 'Unable to connect to Web Action API' unless @res.code.to_i < 400
  end
end
