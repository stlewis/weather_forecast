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
      expect(current_weather.temperature).to eq(raw_response['current']['temp'].round)
    end

    it 'sets the feels like temperature' do
      expect(current_weather.feels_like).to eq(raw_response['current']['feels_like'].round)
    end

    it 'sets the humidity' do
      expect(current_weather.humidity).to eq(raw_response['current']['humidity'].round)
    end

    it 'sets the wind speed' do
      expect(current_weather.wind_speed).to eq(raw_response['current']['wind_speed'])
    end

    it 'sets the wind direction' do
      expect(current_weather.wind_direction).to eq('S')
    end

    it 'sets sunrise' do
      expect(current_weather.sunrise).to eq(Time.at(raw_response['current']['sunrise']).strftime('%H:%M'))
    end

    it 'sets sunset' do
      expect(current_weather.sunset).to eq(Time.at(raw_response['current']['sunset']).strftime('%H:%M'))
    end

    it 'sets the UV index' do
      expect(current_weather.uv_index).to eq(raw_response['current']['uvi'])
    end
  end

  describe '#summary' do
    it 'returns a summary of the current weather' do
      raw_data = current_weather.raw_data
      expected_summary = <<~SUMMARY
          It is #{Time.at(raw_data['dt']).strftime('%a %b %d')}. The current temperature is #{raw_data['temp'].round}°F, but it feels like #{raw_data['feels_like'].round}°F.
        The humidity is #{raw_data['humidity']}% and the wind speed is #{raw_data['wind_speed']} mph out of the #{current_weather.wind_direction}. The current UV index is #{raw_data['uvi']}.
        Sunrise is at #{Time.at(raw_data['sunrise']).strftime('%H:%M')} and sunset is at #{Time.at(raw_data['sunset']).strftime('%H:%M')}.
      SUMMARY

      expect(current_weather.summary.squish)
        .to eq(expected_summary.squish)
    end
  end
end
