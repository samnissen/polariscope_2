json.array!(@data_elements) do |data_element|
  json.extract! data_element, :id, :key, :value, :environment_id, :user_id
  json.url data_element_url(data_element, format: :json)
end
