# frozen_string_literal: true

module AddressValidation
  # Configuration class for Google Maps Address Validation api
  class Configuration
    attr_accessor :api_key, :region_code

    def initialize
      @api_key = nil
      @region_code = 'US'
    end
  end
end
