json.array!(@admin_sites) do |admin_site|
  json.extract! admin_site, :id
  json.url admin_site_url(admin_site, format: :json)
end
