require "rails_helper"

RSpec.describe WeatherReportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/weather_reports").to route_to("weather_reports#index")
    end

    it "routes to #new" do
      expect(get: "/weather_reports/new").to route_to("weather_reports#new")
    end

    it "routes to #show" do
      expect(get: "/weather_reports/1").to route_to("weather_reports#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/weather_reports/1/edit").to route_to("weather_reports#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/weather_reports").to route_to("weather_reports#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/weather_reports/1").to route_to("weather_reports#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/weather_reports/1").to route_to("weather_reports#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/weather_reports/1").to route_to("weather_reports#destroy", id: "1")
    end
  end
end
