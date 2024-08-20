require 'rails_helper'

RSpec.describe "weather_reports/edit", type: :view do
  let(:weather_report) {
    WeatherReport.create!()
  }

  before(:each) do
    assign(:weather_report, weather_report)
  end

  it "renders the edit weather_report form" do
    render

    assert_select "form[action=?][method=?]", weather_report_path(weather_report), "post" do
    end
  end
end
