# frozen_string_literal: true

module OpenWeather
  # Configuration class for OpenWeather api
  class Configuration
    attr_accessor :api_key, :units, :lang

    def initialize
      @api_key = nil
      @units = 'imperial'
      @lang = 'en'
    end
  end
end
