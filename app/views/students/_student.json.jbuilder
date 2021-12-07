json.extract! student, :id, :name, :birthdate, :lastname, :dni, :email, :active, :references, :created_at, :updated_at
json.url student_url(student, format: :json)
