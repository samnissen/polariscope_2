json.array!(@did_you_mean_types) do |did_you_mean_type|
  json.extract! did_you_mean_type, :id, :description, :key, :archived
  json.url did_you_mean_type_url(did_you_mean_type, format: :json)
end
