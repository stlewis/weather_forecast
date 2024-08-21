# frozen_string_literal: true

module OpenWeather
  # Base class for OpenWeather forecast information
  class CurrentWeather < WeatherData
    def initialize(raw_data)
      super(raw_data)

      @date = Date.today
      @temperature = raw_data['temp'].round
      @feels_like = raw_data['feels_like'].round
      @uv_index = raw_data['uvi']

      @humidity = raw_data['humidity']
      @wind_speed = raw_data['wind_speed']
      @wind_deg = raw_data['wind_deg']
      @sunrise = Time.at(raw_data['sunrise']).strftime('%H:%M')
      @sunset = Time.at(raw_data['sunset']).strftime('%H:%M')
    end

    def summary
      <<~SUMMARY
          It is #{@date.strftime('%a %b %d')}. The current temperature is #{@temperature}°F. It feels like #{@feels_like}°F.
        The humidity is #{@humidity}% and the wind speed is #{@wind_speed} mph out of the #{wind_direction}. The current UV index is #{@uv_index}.
        Sunrise is at #{@sunrise} and sunset is at #{@sunset}.
      SUMMARY
    end
  end
end
