class WeatherReportsController < ApplicationController
  def new
    # Interface to query the weather API
  end

  def by_address
    address_params = {
      street: params[:street],
      city: params[:city],
      state: params[:state]
    }

    raise ActionController::ParameterMissing.new('street') unless params[:street].present?
    raise ActionController::ParameterMissing.new('city') unless params[:city].present?
    raise ActionController::ParameterMissing.new('state') unless params[:state].present?

    address_params[:zip_code] = params[:zip_code] if params[:zip_code].present?

    valid_address = AddressValidation.standardize_address(address: address_params)

    @cached_report = true

    weather_report = Rails.cache.fetch("weather_report_#{valid_address.zip_code}", expires_in: 30.minutes) do
      @cached_report = false
      OpenWeather.weather_for(zip_code: valid_address.zip_code)
    end

    @current_weather = weather_report[:current_weather]
    @daily_forecasts = weather_report[:forecast]
  rescue ActionController::ParameterMissing => e
    flash[:error] = "#{e.message}. Please provide a valid address"
    redirect_to new_weather_report_path
  rescue AddressValidation::Api::Error, OpenWeather::Api::Error => e
    flash[:error] = e.message
    redirect_to new_weather_report_path
  end
end
