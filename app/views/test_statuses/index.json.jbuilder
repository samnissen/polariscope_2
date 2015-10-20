json.array!(@test_statuses) do |test_status|
  json.extract! test_status, :id, :run_test_id, :browser_type_id, :success, :notes, :log
  json.url test_status_url(test_status, format: :json)
end
