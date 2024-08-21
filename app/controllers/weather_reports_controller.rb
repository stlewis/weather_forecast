class WeatherReportsController < ApplicationController
  def new
    # Interface to query the weather API
  end

  def by_address
    # Query the cache
    # If the cache is empty, query the weather API
    # Save the result in the cache

    @cached_report = true

    Rails.cache.fetch("weather_report_#{params[:zip]}", expires_in: 30.minutes) do
      @cached_report = false
      weather_report = OpenWeather.weather_for(zip_code: params[:zip])
      @current_weather = weather_report[:current_weather]
      @daily_forecasts = weather_report[:forecast]
    end
  end
end
