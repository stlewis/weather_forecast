# frozen_string_literal: true

require_relative '../../app/lib/address_validation'

AddressValidation.configure do |config|
  config.api_key = Rails.application.credentials.google[:api_key]
  config.region_code = 'US'
end
