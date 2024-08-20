# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenWeather::CurrentWeather do
  let(:raw_response) { JSON.parse(File.read('spec/fixtures/onecall_response.json')) }
  subject(:current_weather) { described_class.new(raw_response['current']) }

  describe '#initialize' do
    it 'sets the date' do
      expect(current_weather.date).to eq(Date.today)
    end

    it 'sets the temperature' do
      expect(current_weather.temperature).to eq(raw_response['current']['temp'])
    end

    it 'sets the feels like temperature' do
      expect(current_weather.feels_like).to eq(raw_response['current']['feels_like'])
    end

    it 'sets the humidity' do
      expect(current_weather.humidity).to eq(raw_response['current']['humidity'])
    end

    it 'sets the wind speed' do
      expect(current_weather.wind_speed).to eq(raw_response['current']['wind_speed'])
    end

    it 'sets the wind direction' do
      expect(current_weather.wind_direction).to eq('S')
    end
  end

  describe '#summary' do
    it 'returns a summary of the current weather' do
      expect(current_weather.summary)
        .to eq("The current temperature is #{raw_response['current']['temp']}°F, but it feels like #{raw_response['current']['feels_like']}°F. The humidity is #{raw_response['current']['humidity']}% and the wind speed is #{raw_response['current']['wind_speed']} mph out of the S.")
    end
  end
end
