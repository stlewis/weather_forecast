# frozen_string_literal: true

module OpenWeather
  module Api
    # OpenWeather Geocoding API endpoints
    class Geocoding < Base
      base_uri 'https://api.openweathermap.org/geo/1.0'

      def by_zip_code(zip_code:)
        options = { query: { zip: zip_code, appid: OpenWeather.configuration.api_key } }
        response = self.class.get('/zip', options)

        return response.parsed_response if response.code.between?(200, 299)

        raise OpenWeather::Api::Error, response['message']
      end
    end
  end
end
