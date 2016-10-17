json.array!(@x_did_you_means) do |x_did_you_mean|
  json.extract! x_did_you_mean, :id, :action_status_id, :possibility, :did_you_mean_type_id
  json.url x_did_you_mean_url(x_did_you_mean, format: :json)
end
