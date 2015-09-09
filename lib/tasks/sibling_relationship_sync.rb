class SiblingRelationshipSync
  def initialize
    @con = APIConnection.new
    @path = "/api/v1/sibling_relationships.json"
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
    @relationships = JSON.parse(@res.body)
    
    # Add any new, or modify as necessary
    @relationships.each do |rel|
      SiblingRelationship.find_or_initialize_by(relation: rel["relation"]).tap do |a|
        a.relation  = rel["relation"]
        a.save!
      end
    end

    # Remove any that don't exist in the source
    invalids = SiblingRelationship.all.map { |oldsibrel|
      oldsibrel unless @relationships.map { |newsibrel|
        true if (newsibrel["relation"] == oldsibrel.relation)
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
