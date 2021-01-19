require 'rails_helper'

describe 'Yelp Service' do
  describe 'class methods' do
      it 'can get retaurant info from Yelp' do
        params = {'end': 'Pueblo,CO',
                  'food': 'chinese'
                    }
        time = 1611073922
        results = YelpService.find_place(params, time)
        expect(results).to be_a(Hash)
        expect(results).to have_key(:businesses)
        expect(results[:businesses]).to be_a(Array)
        expect(results[:businesses][0]).to have_key(:name)
        expect(results[:businesses][0][:name]).to be_a(String)
        expect(results[:businesses][0]).to have_key(:location)
        expect(results[:businesses][0][:location]).to be_a(Hash)
        expect(results[:businesses][0][:location]).to have_key(:display_address)
        expect(results[:businesses][0][:location][:display_address]).to be_a(Array)
        expect(results[:businesses][0][:location][:display_address][0]).to be_a(String)

        #
        # expect(results[:value].first).to have_key(:name)
        # expect(results[:value].first[:name]).to be_a(String)
        # expect(results[:value].first).to have_key(:contentUrl)
        # expect(results[:value].first[:contentUrl]).to be_a(String)
        # expect(results[:value].first).to have_key(:hostPageUrl)
        # expect(results[:value].first[:hostPageUrl]).to be_a(String)
        # expect(results[:value].first).to have_key(:hostPageDomainFriendlyName)
        # expect(results[:value].first[:hostPageDomainFriendlyName]).to be_a(String)
        # expect(results[:value].first).to have_key(:hostPageFavIconUrl)
        # expect(results[:value].first[:hostPageFavIconUrl]).to be_a(String)
     end
    end
  end
