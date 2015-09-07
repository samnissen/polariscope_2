json.array!(@object_identifier_siblings) do |object_identifier_sibling|
  json.extract! object_identifier_sibling, :id, :identifier, :id_type, :selector, :object_identifier_id, :sibling_relationship_id, :user_id
  json.url object_identifier_sibling_url(object_identifier_sibling, format: :json)
end
