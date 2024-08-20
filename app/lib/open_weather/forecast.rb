# frozen_string_literal: true

module OpenWeather
  # Base class for OpenWeather forecast information
  class Forecast < WeatherData
    attr_reader :summary, :min_temp, :max_temp, :night_temp, :eve_temp,
                :morn_temp, :night_feels, :eve_feels, :morn_feels

    def initialize(raw_data)
      super(raw_data)

      @date = Time.at(raw_data['dt']).to_date
      @summary = raw_data['summary']
      @humidity = raw_data['humidity']
      @wind_speed = raw_data['wind_speed']
      @wind_deg = raw_data['wind_deg']
      @min_temp = raw_data['temp']['min']
      @max_temp = raw_data['temp']['max']
      @night_temp = raw_data['temp']['night']
      @eve_temp = raw_data['temp']['eve']
      @morn_temp = raw_data['temp']['morn']
      @night_feels = raw_data['feels_like']['night']
      @eve_feels = raw_data['feels_like']['eve']
      @morn_feels = raw_data['feels_like']['morn']
    end
  end
end
