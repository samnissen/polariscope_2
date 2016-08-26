class DidYouMeanTypeSync
  def initialize
    @con = APIConnection.new
    @path = "/api/v1/did_you_mean_types.json"
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
  handle_asynchronously :queue_next, :queue => 'did_you_mean_types', :run_at => Proc.new { 24.hours.from_now }

  def parse
    @did_you_mean_types = JSON.parse(@res.body)

    # Add any new, or modify as necessary
    @did_you_mean_types.each do |dym_type|
      DidYouMeanType.find_or_initialize_by(key: dym_type["key"]).tap do |dt|
        dt.description  = rel["description"]
        dt.archived  = false
        dt.save!
      end
    end

    # Remove any that don't exist in the source
    invalids = DidYouMeanType.all.map { |olddymtype|
      olddymtype unless @did_you_mean_types.map { |newdymtype|
        true if (newdymtype["key"] == olddymtype.key)
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
