json.array!(@object_identifiers) do |object_identifier|
  json.extract! object_identifier, :id, :identifier, :id_type, :selector, :test_action_id, :user_id
  json.url object_identifier_url(object_identifier, format: :json)
end
