class ObjectTypeSync
  def initialize
    @con = APIConnection.new
    @path = "/api/v1/object_types.json"
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
  handle_asynchronously :queue_next, :queue => 'object_types', :run_at => Proc.new { 24.hours.from_now }

  def parse
    @object_types = JSON.parse(@res.body)

    # Add any new, or modify as necessary
    @object_types.each do |sel|
      ObjectType.find_or_initialize_by(type_name: sel["type_name"]).tap do |a|
        a.type_name  = sel["type_name"]
        a.html  = sel["html"]
        a.save!
      end
    end

    # Remove any that don't exist in the source
    invalids = ObjectType.all.map { |oldot|
      oldot unless @object_types.map { |newot|
        true if (newot["type_name"] == oldot.type_name)
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
