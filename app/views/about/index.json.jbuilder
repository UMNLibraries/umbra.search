json.array!(@about) do |about|
  json.extract! about, :id, :title, :body, :link_title, :link_path
  json.url about_url(about, format: :json)
end
