json.page do
  json.total_pages @albums.total_pages
  json.current_page params[:page] || 1
end

json.data @albums do |album|
  json.id album.id.to_s
  json.thumbnail album.thumbnail
  json.tags album.tags
  json.title album.title
end
