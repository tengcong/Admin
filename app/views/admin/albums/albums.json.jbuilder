json.page do
  json.total_pages @albums.total_pages
  if params[:page]
    json.current_page params[:page].to_i
  else
    json.current_page 1
  end
end

json.data @albums do |album|
  json.id album.id.to_s
  json.thumbnail album.thumbnail
  json.tags album.tags
  json.title album.title
end
