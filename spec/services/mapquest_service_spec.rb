require 'rails_helper'

describe 'Mapquest Service' do
  describe 'class methods' do
    context '#get_results' do
      it 'can call Mapquest Geocoding API to get coordinates with location parameter' do
        location = 'denver,co'
        map_response = MapquestService.city_results(location)

        expect(map_response).to be_a(Hash)
        expect(map_response).to have_key(:results)
        expect(map_response[:results]).to be_a(Array)
        expect(map_response[:results][0]).to be_a(Hash)
        expect(map_response[:results][0]).to have_key(:locations)
        expect(map_response[:results][0][:locations]).to be_a(Array)
        expect(map_response[:results][0][:locations][0]).to be_a(Hash)
        expect(map_response[:results][0][:locations][0]).to have_key(:latLng)
        expect(map_response[:results][0][:locations][0][:latLng]).to be_a(Hash)
        expect(map_response[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(map_response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
        expect(map_response[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(map_response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
      end
    end
  end
end
