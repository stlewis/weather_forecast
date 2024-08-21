# frozen_string_literal: true

require_relative 'address_validation/configuration'

# Module containing mechanisms to access the OpenWeather APIs.
module AddressValidation
  class ParseError < StandardError; end

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
      struct_from_response(response)
    end

    private

    def struct_from_response(response)
      address_data = response['result']['address']['postalAddress']

      raise ParseError, 'Could not parse address data' if address_data.nil?

      street = address_data['addressLines'].first
      city = address_data['locality']
      state = address_data['administrativeArea']
      zip_code = address_data['postalCode']

      if street.nil? || city.nil? || state.nil? || zip_code.nil?
        raise ParseError, 'Could not parse address data'
      end

      OpenStruct.new(
        street: street,
        city: city,
        state: state,
        zip_code: zip_code.split('-').first,
      )
    end
  end
end
