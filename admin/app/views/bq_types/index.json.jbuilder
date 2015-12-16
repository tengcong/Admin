json.array!(@bq_types) do |bq_type|
  json.extract! bq_type, :id
  json.url bq_type_url(bq_type, format: :json)
end
