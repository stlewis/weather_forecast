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
      @min_temp = raw_data['temp']['min'].round
      @max_temp = raw_data['temp']['max'].round
      @night_temp = raw_data['temp']['night'].round
      @eve_temp = raw_data['temp']['eve'].round
      @morn_temp = raw_data['temp']['morn'].round
      @night_feels = raw_data['feels_like']['night'].round
      @eve_feels = raw_data['feels_like']['eve'].round
      @morn_feels = raw_data['feels_like']['morn'].round

      @humidity = raw_data['humidity']
      @wind_speed = raw_data['wind_speed']
      @wind_deg = raw_data['wind_deg']
      @sunrise = Time.at(raw_data['sunrise']).strftime('%H:%M')
      @sunset = Time.at(raw_data['sunset']).strftime('%H:%M')
      @uv_index = raw_data['uvi']
    end
  end
end
