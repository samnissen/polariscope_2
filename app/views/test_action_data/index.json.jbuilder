json.array!(@test_action_data) do |test_action_datum|
  json.extract! test_action_datum, :id, :data, :test_action_id
  json.url test_action_datum_url(test_action_datum, format: :json)
end
