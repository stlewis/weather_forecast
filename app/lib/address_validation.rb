# frozen_string_literal: true

require_relative 'address_validation/configuration'

# Module containing mechanisms to access the OpenWeather APIs.
module AddressValidation
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def standardize_address(address:)
      response = AddressValidation::Api::Base.new.validate_address(address)
      return struct_from_response(response) if response.code.between?(200, 299)

      raise AddressValidation::Api::Error, response['error']['message']
    end

    private

    def struct_from_response(response)
      address_data = response['result']['address']['postalAddress']

      street = address_data['addressLines'].first
      city = address_data['locality']
      state = address_data['administrativeArea']
      zip_code = address_data['postalCode'].split('-').first

      OpenStruct.new(
        street: street,
        city: city,
        state: state,
        zip_code: zip_code
      )
    end
  end
end
