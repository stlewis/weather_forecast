require 'rails_helper'

RSpec.describe "weather_reports/show", type: :view do
  before(:each) do
    assign(:weather_report, WeatherReport.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
