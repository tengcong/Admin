json.page do
  json.total_pages @collection.total_pages

  if params[:page]
    json.current_page params[:page].to_i
  else
    json.current_page 1
  end
end


json.data @collection do |bq_package|
  json.id album.id.to_s
  json.name album.title
  json.thumbnail album.thumbnail
end
