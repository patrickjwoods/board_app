json.array!(@ideas) do |idea|
  json.extract! idea, :id, :url, :board_id
  json.url idea_url(idea, format: :json)
end
