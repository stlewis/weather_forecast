# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenWeather::Forecast do
  let(:raw_response) { JSON.parse(File.read('spec/fixtures/onecall_response.json')) }
  subject(:forecast) { described_class.new(raw_response['daily'][0]) }

  describe '#initialize' do
    it 'sets the date' do
      expect(forecast.date).to eq(Time.at(raw_response['daily'][0]['dt']).to_date)
    end

    it 'sets the summary' do
      expect(forecast.summary).to eq(raw_response['daily'][0]['summary'])
    end

    it 'sets the min temperature' do
      expect(forecast.min_temp).to eq(raw_response['daily'][0]['temp']['min'].round)
    end

    it 'sets the max temperature' do
      expect(forecast.max_temp).to eq(raw_response['daily'][0]['temp']['max'].round)
    end

    it 'sets the night temperature' do
      expect(forecast.night_temp).to eq(raw_response['daily'][0]['temp']['night'].round)
    end

    it 'sets the evening temperature' do
      expect(forecast.eve_temp).to eq(raw_response['daily'][0]['temp']['eve'].round)
    end

    it 'sets the morning temperature' do
      expect(forecast.morn_temp).to eq(raw_response['daily'][0]['temp']['morn'].round)
    end

    it 'sets the night feels like temperature' do
      expect(forecast.night_feels).to eq(raw_response['daily'][0]['feels_like']['night'].round)
    end

    it 'sets the evening feels like temperature' do
      expect(forecast.eve_feels).to eq(raw_response['daily'][0]['feels_like']['eve'].round)
    end

    it 'sets the morning feels like temperature' do
      expect(forecast.morn_feels).to eq(raw_response['daily'][0]['feels_like']['morn'].round)
    end

    it 'sets the humidity' do
      expect(forecast.humidity).to eq(raw_response['daily'][0]['humidity'])
    end

    it 'sets the wind speed' do
      expect(forecast.wind_speed).to eq(raw_response['daily'][0]['wind_speed'])
    end

    it 'sets the wind direction' do
      expect(forecast.wind_deg).to eq(raw_response['daily'][0]['wind_deg'])
    end

    it 'sets the sunrise time' do
      expect(forecast.sunrise).to eq(Time.at(raw_response['daily'][0]['sunrise']).strftime('%H:%M'))
    end

    it 'sets the sunset time' do
      expect(forecast.sunset).to eq(Time.at(raw_response['daily'][0]['sunset']).strftime('%H:%M'))
    end

    it 'sets the UV index' do
      expect(forecast.uv_index).to eq(raw_response['daily'][0]['uvi'])
    end
  end
end
