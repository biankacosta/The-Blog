json.extract! post, :id, :name, :title, :text, :created_at, :updated_at
json.url post_url(post, format: :json)
