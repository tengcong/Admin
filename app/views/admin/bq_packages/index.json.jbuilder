json.array!(@bq_packages) do |bq_package|
  json.extract! bq_package, :id
  json.url admin_bq_package_url(bq_package, format: :json)
end
