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
      expect(forecast.min_temp).to eq(raw_response['daily'][0]['temp']['min'])
    end

    it 'sets the max temperature' do
      expect(forecast.max_temp).to eq(raw_response['daily'][0]['temp']['max'])
    end

    it 'sets the night temperature' do
      expect(forecast.night_temp).to eq(raw_response['daily'][0]['temp']['night'])
    end

    it 'sets the evening temperature' do
      expect(forecast.eve_temp).to eq(raw_response['daily'][0]['temp']['eve'])
    end

    it 'sets the morning temperature' do
      expect(forecast.morn_temp).to eq(raw_response['daily'][0]['temp']['morn'])
    end

    it 'sets the night feels like temperature' do
      expect(forecast.night_feels).to eq(raw_response['daily'][0]['feels_like']['night'])
    end

    it 'sets the evening feels like temperature' do
      expect(forecast.eve_feels).to eq(raw_response['daily'][0]['feels_like']['eve'])
    end

    it 'sets the morning feels like temperature' do
      expect(forecast.morn_feels).to eq(raw_response['daily'][0]['feels_like']['morn'])
    end
  end
end
