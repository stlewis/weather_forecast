# frozen_string_literal: true

require_relative '../../app/lib/open_weather'

OpenWeather.configure do |config|
  config.api_key = Rails.application.credentials.open_weather[:api_key]
end
