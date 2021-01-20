require "rails_helper"

describe 'Hourly Poro', :vcr do
    before :each do
      location = 'austin,tx'
      map_results = MapquestService.city_results(location)
      params = map_results[:results][0][:locations][0][:latLng]
      result = WeatherService.get_forecast(params)
      @data = (result[:hourly][0..7])
      @hourly_poro = ForecastFacade.create_hourly_poro(result[:hourly][0..7])
    end

    it 'exists' do
      expect(@hourly_poro).to be_a(Array)
      expect(@hourly_poro[0]).to be_a(Hourly)
      expect(@hourly_poro[0].time).to be_a(String)
      expect(@hourly_poro[0].temperature).to be_a(Float)
      expect(@hourly_poro[0].wind_speed).to be_a(String)
      expect(@hourly_poro[0].wind_direction).to be_a(String)
      expect(@hourly_poro[0].conditions).to be_a(String)
      expect(@hourly_poro[0].icon).to be_a(String)
    end

  describe 'instance methods' do
    it 'finds wind direction based off direction degree' do
      expect(@hourly_poro[0].find_direction(15)).to eq('from NNE')
      expect(@hourly_poro[0].find_direction(40)).to eq('from NE')
      expect(@hourly_poro[0].find_direction(60)).to eq('from ENE')
      expect(@hourly_poro[0].find_direction(90)).to eq('from E')
      expect(@hourly_poro[0].find_direction(110)).to eq('from ESE')
      expect(@hourly_poro[0].find_direction(130)).to eq('from SE')
      expect(@hourly_poro[0].find_direction(150)).to eq('from SSE')
      expect(@hourly_poro[0].find_direction(170)).to eq('from S')
      expect(@hourly_poro[0].find_direction(200)).to eq('from SSW')
      expect(@hourly_poro[0].find_direction(220)).to eq('from SW')
      expect(@hourly_poro[0].find_direction(240)).to eq('from WSW')
      expect(@hourly_poro[0].find_direction(260)).to eq('from W')
      expect(@hourly_poro[0].find_direction(290)).to eq('from WNW')
      expect(@hourly_poro[0].find_direction(310)).to eq('from NW')
      expect(@hourly_poro[0].find_direction(350)).to eq('from N')
    end
  end
end
