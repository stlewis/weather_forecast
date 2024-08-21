# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenWeather::Api::Geocoding do
  describe '#by_zip_code' do
    it 'returns the geocoding data for a given zip code' do
      VCR.use_cassette('geocoding/by_zip') do
        geocoding = OpenWeather::Api::Geocoding.new.by_zip_code(zip_code: '90210')

        expect(geocoding['lat']).to eq(34.0901)
        expect(geocoding['lon']).to eq(-118.4065)
      end
    end

    context 'with an invalid zip code' do
      it 'returns an error' do
        VCR.use_cassette('geocoding/by_invalid_zip') do
          expect { OpenWeather::Api::Geocoding.new.by_zip_code(zip_code: '00000') }
            .to raise_error(OpenWeather::Api::Error)
            .with_message('not found')
        end
      end
    end
  end
end
