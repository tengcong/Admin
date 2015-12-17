json.array!(@bq_packages) do |bq_package|
  # json.extract! bq_package, :id
  json.id bq_package.id.to_s
  json.name bq_package.name
  json.thumbnail bq_package.bqs.first.origin_url
end
