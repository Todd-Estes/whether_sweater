require 'rails_helper'

describe 'Weather Service' do
  describe 'class methods' do
    context '#city_results' do
      it 'returns city weather data' do
        city = 'austin,co'
        results = WeatherService.city_results(city)

        expect(results).to be_a(Hash)
        expect(results[:whatever]).to be_a(whatever)

      end
      #work out sad path/edge case testing
    end
  end
end
