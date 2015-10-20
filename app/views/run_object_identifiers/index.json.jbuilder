json.array!(@run_object_identifiers) do |run_object_identifier|
  json.extract! run_object_identifier, :id, :identifier, :id_type, :selector, :run_test_action_id
  json.url run_object_identifer_url(run_object_identifier, format: :json)
end
