json.array!(@scheduled_tests) do |scheduled_test|
  json.extract! scheduled_test, :id, :notes, :collection_id, :test_ids, :next_test, :recurring
  json.url scheduled_test_url(scheduled_test, format: :json)
end
