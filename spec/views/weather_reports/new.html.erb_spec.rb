require 'rails_helper'

RSpec.describe "weather_reports/new", type: :view do
  before(:each) do
    assign(:weather_report, WeatherReport.new())
  end

  it "renders new weather_report form" do
    render

    assert_select "form[action=?][method=?]", weather_reports_path, "post" do
    end
  end
end
