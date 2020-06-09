json.extract! room, :id, :name, :cost, :length, :width, :amount, :allow, :description, :created_at, :updated_at
json.url room_url(room, format: :json)
