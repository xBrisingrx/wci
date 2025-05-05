# in config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://www.wellcontrol.la"
    resource "*",
      headers: :any,
      methods: [:post],
      credentials: true,
      max_age: 86400
  end
end