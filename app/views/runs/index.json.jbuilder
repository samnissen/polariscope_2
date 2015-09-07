json.array!(@runs) do |run|
  json.extract! run, :id, :name, :description, :collection_id
  json.url run_url(run, format: :json)
end
