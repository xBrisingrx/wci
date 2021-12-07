json.extract! course, :id, :start_date, :finish_date, :start_hour, :finish_hour, :created_at, :updated_at
json.url course_url(course, format: :json)
