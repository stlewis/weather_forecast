# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenWeather::Api::Onecall do
  describe '#weather' do
    let(:lat) { 37.7749 }
    let(:lon) { -122.4194 }

    it 'returns the weather for a given latitude and longitude' do
      VCR.use_cassette('onecall/weather') do
        response = described_class.new.weather(lat: lat, lon: lon)
        expect(response['lat']).to eq(lat)
        expect(response['lon']).to eq(lon)
        expect(response['timezone']).to eq('America/Los_Angeles')
        expect(response['current']).to be_present
        expect(response['daily']).to be_present
      end
    end

    context 'when the geo coordinates are invalid' do
      it 'raises an error' do
        VCR.use_cassette('onecall/invalid') do
          expect { described_class.new.weather(lat: 'should', lon: 'break') }
            .to raise_error(OpenWeather::Api::Error).with_message('wrong latitude')
        end
      end
    end
  end
end
