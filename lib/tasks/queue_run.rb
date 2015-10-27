API_GET_LIMIT = 200
API_POST_LIMIT = 50

class QueueRun
  def initialize
    @con = APIConnection.new
    @email = YAML.load(ERB.new(File.read(Rails.root.join('config', 'web_action_api.yml'))).result)[Rails.env]['email']
    @token = YAML.load(ERB.new(File.read(Rails.root.join('config', 'web_action_api.yml'))).result)[Rails.env]['token']
    @format = 'json'
  end

  def work
    begin
      get_outstanding

      post_new
    ensure
      queue_next
    end
  end

  def queue_next
    work
  end
  handle_asynchronously :queue_next, :queue => 'runs', :run_at => Proc.new { 1.minute.from_now }

  def post_new
    # TestStatus.where(browser_type: BrowserType.where(key: 'delete-me-get-crunk')).limit(15).each do |ts|
    TestStatus.where(api_id: nil).limit(API_POST_LIMIT).each do |ts|
      post_run_test(ts, ts.run_test); sleep(0.075)
    end
  end

  def post_run_test(test_status, run_test)
    res = @con.request(
      :post,
      "/api/v1/orders.json",
      {
        'order[browser_type]' => test_status.browser_type.key,
      }.merge(auth_params)
    )

    errorizer(res, run_test, {:type => 'posting', :model => 'order'})

    order_id = safe_parser(res.body, 'id')

    test_status.update_attribute(:api_id, order_id)

    # run_test.run_test_actions.limit(3).each do |rta|
    run_test.run_test_actions.each do |rta|
      post_run_test_action(rta, order_id)
    end

    unlock_run_test(order_id, run_test)
  end

  def post_run_test_action(rta, order_id)
    res = @con.request(
      :post,
      "/api/v1/orders/#{order_id}/order_actions.json",
      {
        'order_action[order_id]' => order_id,
        'order_action[activity_name]' => rta.activity.action_name
      }.merge(auth_params)
    )
    errorizer(res, rta, {:type => 'posting', :model => 'order action'})

    order_action_id = safe_parser(res.body, 'id')

    post_run_object_identifier(rta.run_object_identifier, order_action_id, order_id) if rta.run_object_identifier
  end

  def post_run_object_identifier(run_object_identifier, order_action_id, order_id)
    res = @con.request(
      :post,
      %{/api/v1/orders/#{order_id}
        /order_actions/#{order_action_id}/
        order_action_objects
      .json}.gsub(/\s+/, ''),
      {
        'order_action_object[object_id_text]' => run_object_identifier.identifier,
        'order_action_object[object_type_id]' => run_object_identifier.object_type_id,
        'order_action_object[id_selector_id]' => run_object_identifier.selector.id,
        'order_action_object[order_action_id]' => order_action_id
      }.merge(auth_params)
    )

    errorizer(res, run_object_identifier, {:type => 'posting', :model => 'order action object'})

    order_action_object_id = safe_parser(res.body, 'id')

    run_object_identifier.run_test_action_data.each do |rta_datum|
      post_test_action_data(rta_datum, order_action_object_id, order_action_id, order_id)
    end

    run_object_identifier.run_object_identifier_siblings.each do |sibling|
      post_run_object_identifier_sibling(sibling, order_action_object_id, order_action_id, order_id)
    end
  end

  def post_test_action_data(test_data, order_action_object_id, order_action_id, order_id)
    res = @con.request(
      :post,
      %{/api/v1/orders/#{order_id}/
        order_actions/#{order_action_id}/
        order_action_objects/#{order_action_object_id}/
        order_action_data
      .json}.gsub(/\s+/, ''),
      {
        'order_action_data[data_code]' => test_data.data,
        'order_action_data[order_action_object_id]' => order_action_object_id
      }.merge(auth_params)
    )

    errorizer(res, test_data, {:type => 'posting', :model => 'order action data'})
  end

  def post_run_object_identifier_sibling(sibling, order_action_object_id, order_action_id, order_id)
    res = @con.request(
      :post,
      %{/api/v1/orders/#{order_id}/
        order_actions/#{order_action_id}/
        order_action_objects/#{order_action_object_id}/
        order_action_object_siblings
      .json}.gsub(/\s+/, ''),
      {
        'order_action_object_sibling[object_id_text]' => sibling.identifier,
        'order_action_object_sibling[object_type_type_name]' => sibling.object_type.type_name,
        'order_action_object_sibling[id_selector_selector_name]' => sibling.selector.selector_name,
        'order_action_object_sibling[relationship_relation]' => sibling.sibling_relationship.relation,
        'order_action_object_sibling[order_action_object_id]' => order_action_object_id
      }.merge(auth_params)
    )

    errorizer(res, sibling, {:type => 'posting', :model => 'order action object sibling'})
  end

  def unlock_run_test(order_id, run_test)
    res = @con.request(
      :put,
      "/api/v1/orders/#{order_id}.json",
      {
        'order[locked]' => false
      }.merge(auth_params)
    )

    errorizer(res, run_test, {:type => 'unlocking', :model => 'order'})
  end

  def get_outstanding
    TestStatus.where(success: nil).where.not(api_id: nil).limit(API_GET_LIMIT).each do |ts|
      res = @con.request(
        :get,
        "/api/v1/orders/#{ts.api_id}.json",
        auth_params
      )
      results = JSON.parse(res.body)

      errorizer(res, ts, {:type => 'getting', :model => 'test status'})

      ts.success  = results['success']
      ts.notes    = results['notes']
      ts.log      = results['log']
      ts.save!
    end
  end

  def auth_params
    {
      'user_email' => @email,
      'user_token' => @token,
      'format' => @format
    }
  end

  def safe_parser(body, key)
    begin
      JSON.parse(body)[key]
    rescue JSON::ParserError => e
      nil
    end
  end

  def errorizer(res, obj, opts = {})
    raise %<Error #{opts[:action_type]} #{opts[:model]} with #{obj.inspect}.
    API reported #{res.body}>.gsub(/\s+/, ' ') if "#{res.code}".to_i > 399
  end
end
