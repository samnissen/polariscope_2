json.array!(@run_tests) do |run_test|
  json.extract! run_test, :id, :name, :description, :belongs_to, :belongs_to
  json.url run_test_url(run_test, format: :json)
end
