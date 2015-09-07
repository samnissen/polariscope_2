json.array!(@test_actions) do |test_action|
  json.extract! test_action, :id, :name, :description, :testset_id, :activity_id, :additional_info, :user_id
  json.url test_action_url(test_action, format: :json)
end
