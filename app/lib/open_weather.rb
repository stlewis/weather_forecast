# frozen_string_literal: true

require_relative 'open_weather/configuration'

# Module containing mechanisms to access the OpenWeather APIs.
module OpenWeather
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def weather_for(zip_code:)
      geo_data = OpenWeather::Api::Geocoding.new.by_zip(zip: zip_code)
      weather_data = OpenWeather::Api::Onecall.new.weather(lat: geo_data['lat'], lon: geo_data['lon'])
      current_weather = OpenWeather::CurrentWeather.new(weather_data['current'])
      forecast = weather_data['daily'].map { |day| OpenWeather::Forecast.new(day) }

      { current_weather: current_weather, forecast: forecast }
    end
  end
end
