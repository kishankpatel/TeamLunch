json.extract! event, :id, :name, :description, :date, :created_by, :created_at, :updated_at
json.url event_url(event, format: :json)
