json.array!(@albums) do |album|
  json.id album.id.to_s
  json.thumbnail album.thumbnail
  json.tags album.tags
  json.title album.title
end
