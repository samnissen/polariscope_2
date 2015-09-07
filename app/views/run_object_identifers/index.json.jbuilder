json.array!(@run_object_identifers) do |run_object_identifer|
  json.extract! run_object_identifer, :id, :identifier, :id_type, :selector, :run_test_action_id
  json.url run_object_identifer_url(run_object_identifer, format: :json)
end
