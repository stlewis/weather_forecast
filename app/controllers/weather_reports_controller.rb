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

    address_cache_key = Digest::MD5.hexdigest("address_#{address_params[:street]}_#{address_params[:city]}_#{address_params[:state]}_#{address_params[:zip_code]}")

    valid_address = Rails.cache.fetch(address_cache_key) do
      AddressValidation.standardize_address(address: address_params)
    end

    @cached_report = true

    weather_report = Rails.cache.fetch("weather_report_#{valid_address.zip_code}", expires_in: OpenWeather::CACHE_EXPIRATION) do
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
