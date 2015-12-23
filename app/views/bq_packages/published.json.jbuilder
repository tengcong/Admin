json.page do
  json.total_pages @collection.total_pages
  json.current_page params[:page] || 1
end
json.data @collection do |bq_package|
  json.id bq_package.id.to_s
  json.name bq_package.name
  json.thumbnail bq_package.bqs.first.origin_url
end
