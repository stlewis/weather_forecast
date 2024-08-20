# frozen_string_literal: true

module OpenWeather
  # Base class for OpenWeather weather information
  class WeatherData
    attr_reader :raw_data, :temperature, :feels_like, :humidity, :wind_speed, :wind_deg, :date

    def initialize(raw_data)
      @raw_data = raw_data
    end

    def wind_direction
      case wind_deg
      when 0..22
        'N'
      when 23..67
        'NE'
      when 68..112
        'E'
      when 113..157
        'SE'
      when 158..202
        'S'
      when 203..247
        'SW'
      when 248..292
        'W'
      when 293..337
        'NW'
      when 338..360
        'N'
      else
        'Unknown'
      end
    end
  end
end
