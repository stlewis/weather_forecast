# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenWeather do
  describe '.configuration' do
    it 'returns a Configuration object' do
      expect(OpenWeather.configuration).to be_a(OpenWeather::Configuration)
    end
  end

  describe '.configure' do
    it 'yields the configuration' do
      expect { |b| OpenWeather.configure(&b) }.to yield_with_args(OpenWeather.configuration)
    end
  end

  describe '.weather_for' do
    let(:zip_code) { '90210' }
    let(:geo_data) { { 'lat' => 34.09, 'lon' => -118.41 } }

    let(:current_weather_data) do
      {
        'dt' => 1_632_000_000,
        'sunrise' => 1_632_000_000,
        'sunset' => 1_632_000_000,
        'temp' => 72.0,
        'feels_like' => 72.0,
        'humidity' => 50,
        'dew_point' => 50.0,
        'uvi' => 5.0,
        'visibility' => 10.0,
        'wind_speed' => 5.0,
        'wind_deg' => 180,
        'weather' => [{ 'description' => 'clear sky' }]
      }
    end

    let(:forecast_data) do
      {
        'dt' => 1_632_000_000,
        'sunrise' => 1_632_000_000,
        'sunset' => 1_632_000_000,
        'temp' => { 'day' => 72.0, 'min' => 50.0, 'max' => 80.0, 'night' => 60.0, 'eve' => 70.0, 'morn' => 55.0},
        'feels_like' => { 'day' => 72.0, 'night' => 60.0, 'eve' => 70.0, 'morn' => 55.0 },
        'humidity' => 50,
        'dew_point' => 50.0,
        'uvi' => 5.0,
        'visibility' => 10.0,
        'wind_speed' => 5.0,
        'wind_deg' => 180,
        'weather' => [{ 'description' => 'clear sky' }]
      }
    end

    let(:weather_data) { { 'current' => current_weather_data, 'daily' => [forecast_data] } }

    let(:current_weather) { OpenWeather::CurrentWeather.new(weather_data['current']) }
    let(:forecast) { weather_data['daily'].map { |day| OpenWeather::Forecast.new(day) } }

    before do
      allow(OpenWeather::Api::Geocoding).to receive_message_chain(:new, :by_zip_code).and_return(geo_data)
      allow(OpenWeather::Api::Onecall).to receive_message_chain(:new, :weather).and_return(weather_data)
      allow(OpenWeather::CurrentWeather).to receive(:new).and_return(current_weather)
      allow(OpenWeather::Forecast).to receive(:new).and_return(forecast)
    end

    it 'returns the current weather and forecast' do
      result = OpenWeather.weather_for(zip_code: zip_code)
      expect(result[:current_weather]).to eq(current_weather)
      expect(result[:forecast]).to eq([forecast])
    end

    context 'given a bad zip code' do
      before do
        allow(OpenWeather::Api::Geocoding).to receive_message_chain(:new, :by_zip_code).and_raise(OpenWeather::Api::Error)
      end

      it 'raises an error' do
        expect { OpenWeather.weather_for(zip_code: zip_code) }.to raise_error(OpenWeather::Api::Error)
      end
    end
  end
end
