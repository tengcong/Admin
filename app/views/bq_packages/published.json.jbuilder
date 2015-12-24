json.page do
  json.total_pages @collection.total_pages
  if params[:page]
    json.current_page params[:page].to_i
  else
    json.current_page 1
  end
end
json.data @collection do |bq_package|
  json.id bq_package.id.to_s
  json.name bq_package.name
  json.tags bq_package.tags
  json.thumbnail bq_package.bqs.first.image_url
end
