# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressValidation::Api::Base do
  describe '#validate_address' do
    let(:address) do
      {
        street: '1600 Amphitheatre Parkway',
        city: 'Mountain View',
        state: 'CA'
      }
    end

    it 'returns address data for the given parameters' do
      VCR.use_cassette('address_validation/validate_address') do
        response = described_class.new.validate_address(address)
        address_data = response['result']['address']['postalAddress']

        expect(address_data['locality']).to eq('Mountain View')
        expect(address_data['administrativeArea']).to eq('CA')
        expect(address_data['postalCode']).to eq('94043-1351')
        expect(address_data['addressLines'][0]).to eq('1600 Amphitheatre Pkwy')
      end
    end

    context 'when the request is invalid' do
      it 'raises an error' do
        VCR.use_cassette('address_validation/invalid') do
          expect { described_class.new.validate_address({}) }
            .to raise_error(AddressValidation::Api::Error, /Address lines missing from request/)
        end
      end
    end
  end
end
