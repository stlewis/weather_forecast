json.extract! weather_report, :id, :created_at, :updated_at
json.url weather_report_url(weather_report, format: :json)
