json.extract! company, :id, :name, :cuit, :email, :active, :created_at, :updated_at
json.url company_url(company, format: :json)
