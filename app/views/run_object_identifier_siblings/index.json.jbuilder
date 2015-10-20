json.array!(@run_object_identifier_siblings) do |run_object_identifier_sibling|
  json.extract! run_object_identifier_sibling, :id, :identifier, :id_type, :selector, :run_object_identifier_id, :sibling_relationship_id
  json.url run_object_identifier_sibling_url(run_object_identifier_sibling, format: :json)
end
