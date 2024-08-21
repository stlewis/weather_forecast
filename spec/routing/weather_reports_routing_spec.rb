# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherReportsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/weather_reports/new').to route_to('weather_reports#new')
    end
  end
end
