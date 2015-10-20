json.array!(@action_statuses) do |action_status|
  json.extract! action_status, :id, :run_test_action_id, :browser_type_id, :success, :notes, :log
  json.url action_status_url(action_status, format: :json)
end
