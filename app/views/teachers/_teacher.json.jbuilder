json.extract! teacher, :id, :name, :lastname, :dni, :email, :title, :active, :created_at, :updated_at
json.url teacher_url(teacher, format: :json)
