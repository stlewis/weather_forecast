# frozen_string_literal: true

require_relative 'api/base'
require_relative 'api/geocoding'
require_relative 'api/onecall'

module OpenWeather
  # Module to wrap the OpenWeather API
  module Api
    class Error < StandardError; end
  end
end
