require 'rails_helper'

RSpec.describe '/weather_reports', type: :request do
  describe 'GET /new' do
    it 'returns a 200 status code' do
      get '/weather_reports/new'
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /by_address' do
    context 'given good parameters' do
      it 'returns a 200 status code' do
        VCR.use_cassette('address_validation/validate_address') do
          VCR.use_cassette('onecall/weather') do
            VCR.use_cassette('geocoding/by_zip_mountain_view') do
              get '/weather_reports/by_address', params: { street: '1600 Amphitheatre Parkway', city: 'Mountain View', state: 'CA' }
              expect(response).to have_http_status(200)
            end
          end
        end
      end
    end

    context 'given bad parameters' do
      context 'missing street' do
        it 'redirects to the new action' do
          get '/weather_reports/by_address'
          expect(response).to redirect_to(new_weather_report_path)
          expect(flash[:error]).to eq('param is missing or the value is empty: street. Please provide a valid address')
        end
      end

      context 'missing city' do
        it 'redirects to the new action' do
          get '/weather_reports/by_address', params: { street: '1600 Amphitheatre Parkway' }
          expect(response).to redirect_to(new_weather_report_path)
          expect(flash[:error]).to eq('param is missing or the value is empty: city. Please provide a valid address')
        end

        context 'missing state' do
          it 'redirects to the new action' do
            get '/weather_reports/by_address', params: { street: '1600 Amphitheatre Parkway', city: 'Mountain View' }
            expect(response).to redirect_to(new_weather_report_path)
            expect(flash[:error]).to eq('param is missing or the value is empty: state. Please provide a valid address')
          end
        end
      end
    end

    context 'given an API error' do
      it 'redirects to the new action' do
        VCR.use_cassette('address_validation/invalid') do
          get '/weather_reports/by_address', params: { street: '1600 Amphitheatre Parkway', city: 'Mountain View', state: 'CA' }
          expect(response).to redirect_to(new_weather_report_path)
          expect(flash[:error]).to eq('Address lines missing from request.')
        end
      end
    end
  end
end
