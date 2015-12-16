json.array!(@bqs) do |bq|
  json.extract! bq, :id
  json.url bq_url(bq, format: :json)
  json.img_url bq.origin_url
end
