json.id @bq_package.id.to_s
json.bqs @bq_package.bqs do |bq|
  json.url bq.origin_url
end
