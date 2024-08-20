# frozen_string_literal: true

module OpenWeather
  # Base class for OpenWeather forecast information
  class CurrentWeather < WeatherData
    def initialize(raw_data)
      super(raw_data)

      @date = Date.today
      @temperature = raw_data['temp']
      @feels_like = raw_data['feels_like']
      @humidity = raw_data['humidity']
      @wind_speed = raw_data['wind_speed']
      @wind_deg = raw_data['wind_deg']
    end

    def summary
      "The current temperature is #{@temperature}°F, but it feels like #{@feels_like}°F. The humidity is #{@humidity}% and the wind speed is #{@wind_speed} mph out of the #{wind_direction}."
    end
  end
end
