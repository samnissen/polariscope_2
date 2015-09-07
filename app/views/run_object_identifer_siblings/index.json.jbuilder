json.array!(@run_object_identifer_siblings) do |run_object_identifer_sibling|
  json.extract! run_object_identifer_sibling, :id, :identifier, :id_type, :selector, :run_object_identifer_id, :sibling_relationship_id
  json.url run_object_identifer_sibling_url(run_object_identifer_sibling, format: :json)
end
