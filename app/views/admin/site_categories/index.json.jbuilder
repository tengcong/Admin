json.array!(@admin_site_categories) do |admin_site_category|
  json.extract! admin_site_category, :id
  json.url admin_site_category_url(admin_site_category, format: :json)
end
