# frozen_string_literal: true

module AddressValidation
  module Api
    class Base
      include HTTParty

      base_uri 'https://addressvalidation.googleapis.com/v1:validateAddress'

      def validate_address(address)
        street_address = address[:street].presence || 'Unknown'

        address_object = {
          regionCode: AddressValidation.configuration.region_code,
          addressLines: [street_address]
        }

        address_object[:addressLines][1] = address[:street2] if address[:street2]

        address_object[:postalCode] = address[:zip_code] if address[:zip_code]
        address_object[:locality] = address[:city] if address[:city]
        address_object[:administrativeArea] = address[:state] if address[:state]

        response = self.class.post('/',
                                   query: { key: AddressValidation.configuration.api_key },
                                   body: { address: address_object }.to_json,
                                   headers: default_headers)

        return response.parsed_response if response.code.between?(200, 299)

        raise AddressValidation::Api::Error, response['error']['message'] if response.code != 200
      end

      private

      def default_headers
        {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      end
    end
  end
end
