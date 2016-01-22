json.array!(@admin_crawling_endpoints) do |admin_crawling_endpoint|
  json.extract! admin_crawling_endpoint, :id
  json.url admin_crawling_endpoint_url(admin_crawling_endpoint, format: :json)
end
