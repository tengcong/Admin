json.page do
  json.total_pages @bq_packages.total_pages
  if params[:page]
    json.current_page params[:page].to_i
  else
    json.current_page 1
  end
end

json.data @bq_packages do |bq_package|
  json.id bq_package.id.to_s
  json.tags bq_package.tags
  json.url bq_package.bqs.first.try(:image_url)
end
