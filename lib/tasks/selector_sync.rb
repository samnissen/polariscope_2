class SelectorSync
  def initialize
    @con = APIConnection.new
    @path = "/api/v1/id_selectors.json"
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
  handle_asynchronously :queue_next, :queue => 'selectors', :run_at => Proc.new { 12.hours.from_now }

  def parse
    @selectors = JSON.parse(@res.body)

    # Add any new, or modify as necessary
    @selectors.each do |sel|
      Selector.find_or_initialize_by(selector_name: sel["selector_name"]).tap do |a|
        a.selector_name  = sel["selector_name"]
        a.save!
      end
    end

    # Remove any that don't exist in the source
    invalids = Selector.all.map { |oldsel|
      oldsel unless @selectors.map { |newsel|
        true if (newsel["selector_name"] == oldsel.selector_name)
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
