json.array!(@testsets) do |testset|
  json.extract! testset, :id, :name, :description, :collection_id, :user_id
  json.url testset_url(testset, format: :json)
end
