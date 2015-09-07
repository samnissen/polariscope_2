json.array!(@environments) do |environment|
  json.extract! environment, :id, :name, :user_id
  json.url environment_url(environment, format: :json)
end
