json.array!(@events) do |event|
  json.extract! event, :id, :title, :user, :city, :start_at, :finish_at
  json.url event_url(event, format: :json)
end
