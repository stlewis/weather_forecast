# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather_reports/new', type: :view do
  it 'renders new weather_report form' do
    render
    assert_select 'form[action=?][method=?]', by_address_weather_reports_path, 'get'
  end
end
