require 'rails_helper'

describe 'Daily Poro' do
  it "exists" do
    location = 'denver,co'
    map_results = MapquestService.city_results(location)
    params = map_results[:results][0][:locations][0][:latLng]
    weather_results = WeatherService.get_forecast(params)
    daily_poro = ForecastFacade.create_daily_poro(weather_results[:daily][0..4])

    expect(daily_poro).to be_a(Array)
    expect(daily_poro[0]).to be_a(Daily)
    expect(daily_poro[0].date).to be_a(String)
    expect(daily_poro[0].sunrise).to be_a(String)
    expect(daily_poro[0].sunset).to be_a(String)
    expect(daily_poro[0].max_temp).to be_a(Float)
    expect(daily_poro[0].min_temp).to be_a(Float)
    expect(daily_poro[0].conditions).to be_a(String)
    expect(daily_poro[0].icon).to be_a(String)
  end
end
