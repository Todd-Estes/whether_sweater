require 'rails_helper'

describe 'Weather Service' do
  describe 'class methods' do
    context '#get_forecast' do
      it 'returns city weather data' do
        location = 'austin,co'
        coordinates = MapquestService.city_results(location)
        params = coordinates[:results][0][:locations][0][:latLng]
        results = WeatherService.get_forecast(params)

        expect(results).to be_a(Hash)
        expect(results).to have_key(:current)
        expect(results[:current]).to be_a(Hash)
        expect(results[:current][:dt]).to be_an(Integer)
        expect(results[:current][:sunrise]).to be_an(Integer)
        expect(results[:current][:sunset]).to be_an(Integer)
        expect(results[:current][:temp]).to be_a(Numeric)
        expect(results[:current][:feels_like]).to be_a(Numeric)
        expect(results[:current][:humidity]).to be_a(Numeric)
        expect(results[:current][:uvi]).to be_a(Numeric)
        expect(results[:current][:visibility]).to be_a(Numeric)
        expect(results[:current][:weather][0][:description]).to be_a(String)
        expect(results[:current][:weather][0][:icon]).to be_a(String)

        expect(results).to have_key(:daily)
        expect(results[:daily]).to be_a(Array)
        expect(results[:daily].size).to eq(8)
        expect(results[:daily].first).to be_a(Hash)
        expect(results[:daily].first).to have_key(:temp)
        expect(results[:daily].first[:temp]).to be_a(Hash)
        expect(results[:daily].first[:temp]).to have_key(:min)
        expect(results[:daily].first[:temp][:min]).to be_a(Float)
        expect(results[:daily].first[:temp]).to have_key(:max)
        expect(results[:daily].first[:temp][:max]).to be_an(Float)

        expect(results).to have_key(:hourly)
        expect(results[:hourly]).to be_a(Array)
        expect(results[:hourly].size).to eq(48)
        expect(results[:hourly].first).to be_a(Hash)
        expect(results[:hourly].first).to have_key(:wind_speed)
        expect(results[:hourly].first[:wind_speed]).to be_a(Float)
        expect(results[:hourly].first).to have_key(:wind_deg)
        expect(results[:hourly].first[:wind_deg]).to be_an(Integer)
      end
    end
  end
end
