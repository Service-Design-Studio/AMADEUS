json.extract! upload, :id, :title, :created_at, :updated_at
json.url upload_url(upload, format: :json)
