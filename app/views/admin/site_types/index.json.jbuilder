json.array!(@admin_site_types) do |admin_site_type|
  json.extract! admin_site_type, :id
  json.url admin_site_type_url(admin_site_type, format: :json)
end
