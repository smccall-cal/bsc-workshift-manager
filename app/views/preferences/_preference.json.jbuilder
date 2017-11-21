json.extract! preference, :id, :created_at, :updated_at, :shift, :schedule
json.url user_preference_url(preference, format: :json)
