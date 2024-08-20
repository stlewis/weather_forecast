OpenWeather::Api.configure do |config|
  config.api_key = Rails.application.credentials.open_weather[:api_key]
end
