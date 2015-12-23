json.page do
  json.total_pages @collection.total_pages
  json.current_page 1 || params[:page]
end
json.data @collection do |bq_package|
  json.id album.id.to_s
  json.name album.title
  json.thumbnail album.thumbnail
end
