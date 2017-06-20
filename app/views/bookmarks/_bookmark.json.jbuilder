json.extract! bookmark, :id, :url, :image_bookmark, :title, :description, :created_at, :updated_at
json.url bookmark_url(bookmark, format: :json)