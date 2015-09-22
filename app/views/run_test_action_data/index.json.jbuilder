json.array!(@run_test_action_data) do |run_test_action_datum|
  json.extract! run_test_action_datum, :id, :data, :run_object_identifier_id
  json.url run_test_action_datum_url(run_test_action_datum, format: :json)
end
