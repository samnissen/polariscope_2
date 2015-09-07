json.array!(@run_test_actions) do |run_test_action|
  json.extract! run_test_action, :id, :name, :description, :test_action_id, :run_id, :activity_id, :additional_info
  json.url run_test_action_url(run_test_action, format: :json)
end
