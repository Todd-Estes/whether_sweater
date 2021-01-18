require "rails_helper"

describe 'Hourly Poro' do
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

    #Cannot find way to test the below!
  # describe 'instance methods' do
  #   xit 'finds wind direction based off direction degree' do
  #     expect(@hourly_poro.find_direction(@data[0][:wind_deg].to_f)).to eq('from NNE')
  #   end
  # end
end
