json.extract! client, :id, :firstname, :middlename, :lastname, :clientstatus_id, :created_at, :updated_at
json.url client_url(client, format: :json)
