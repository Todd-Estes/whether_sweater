require 'rails_helper'

describe 'Background Service', :vcr do
  describe 'class methods' do
    context '#city_results' do
      it 'can get image json from Bing Image API' do
        location = 'denver,co'
        results = BackgroundService.get_image(location)
        expect(results).to be_a(Hash)
        expect(results).to have_key(:value)
        expect(results[:value]).to be_a(Array)

        expect(results[:value].first).to have_key(:name)
        expect(results[:value].first[:name]).to be_a(String)
        expect(results[:value].first).to have_key(:contentUrl)
        expect(results[:value].first[:contentUrl]).to be_a(String)
        expect(results[:value].first).to have_key(:hostPageUrl)
        expect(results[:value].first[:hostPageUrl]).to be_a(String)
        expect(results[:value].first).to have_key(:hostPageDomainFriendlyName)
        expect(results[:value].first[:hostPageDomainFriendlyName]).to be_a(String)
        expect(results[:value].first).to have_key(:hostPageFavIconUrl)
        expect(results[:value].first[:hostPageFavIconUrl]).to be_a(String)
     end
    end
  end
end
