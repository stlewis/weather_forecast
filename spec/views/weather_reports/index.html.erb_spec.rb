require 'rails_helper'

RSpec.describe "weather_reports/index", type: :view do
  before(:each) do
    assign(:weather_reports, [
      WeatherReport.create!(),
      WeatherReport.create!()
    ])
  end

  it "renders a list of weather_reports" do
    render
    cell_selector = 'div>p'
  end
end
