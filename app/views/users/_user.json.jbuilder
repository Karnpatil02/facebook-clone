json.extract! user, :id, :email, :password, :first_name, :last_name, :age, :contact, :gender, :created_at, :updated_at
json.url user_url(user, format: :json)
