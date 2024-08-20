# frozen_string_literal: true

module OpenWeather
  module Api
    # Primary interface into the OpenWeather OneCall API
    class Onecall < Base
      base_uri 'https://api.openweathermap.org/data/3.0'

      def weather(lat:, lon:)
        options = {
          query: {
            lat: lat,
            lon: lon,
            units: OpenWeather.configuration.units,
            exclude: 'minutely,hourly',
            appid: OpenWeather.configuration.api_key
          }
        }
        response = self.class.get('/onecall', options)

        return response.parsed_response if response.code.between?(200, 299)

        raise OpenWeather::Api::Error, response['message']
      end
    end
  end
end
