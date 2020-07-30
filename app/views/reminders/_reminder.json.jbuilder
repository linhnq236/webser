json.extract! reminder, :id, :content, :start_time, :end_time, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
