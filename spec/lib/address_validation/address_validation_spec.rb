# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressValidation do
  describe '.configuration' do
    it 'returns a Configuration object' do
      expect(OpenWeather.configuration).to be_a(AddressValidation::Configuration)
    end
  end

  describe '.configure' do
    it 'yields the configuration' do
      expect { |b| AddressValidation.configure(&b) }.to yield_with_args(AddressValidation.configuration)
    end
  end

  describe '.standardize_address' do
    it 'returns an OpenStruct with the address data' do
      address = {
        street: '1600 Amphitheatre Parkway',
        city: 'Mountain View',
        state: 'CA',
        zip_code: '94043'
      }

      response = { 'result' => { 'address' => { 'postalAddress' => { 'addressLines' => ['1600 Amphitheatre Parkway'], 'locality' => 'Mountain View', 'administrativeArea' => 'CA', 'postalCode' => '94043-1351' } } } }

      allow(AddressValidation::Api::Base).to receive(:new).and_return(double(validate_address: response))

      result = AddressValidation.standardize_address(address: address)

      expect(result.street).to eq('1600 Amphitheatre Parkway')
      expect(result.city).to eq('Mountain View')
      expect(result.state).to eq('CA')
      expect(result.zip_code).to eq('94043')
    end

  end
end
