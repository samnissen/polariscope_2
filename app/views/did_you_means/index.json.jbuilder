json.array!(@did_you_means) do |did_you_mean|
  json.extract! did_you_mean, :id, :action_status_id, :possibility, :did_you_mean_type_id
  json.url did_you_mean_url(did_you_mean, format: :json)
end
