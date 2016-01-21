json.array!(@albums) do |album|
  json.extract! album, :id
  json.url admin_album_url(album, format: :json)
end
