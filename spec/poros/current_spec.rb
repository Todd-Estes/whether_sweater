require 'rails_helper'

describe 'Current Poro' do
  it "exists" do
    location = 'denver,co'
    map_results = MapquestService.city_results(location)
    params = map_results[:results][0][:locations][0][:latLng]
    weather_results = WeatherService.get_forecast(params)
    current = CurrentPoro.new(weather_results[:current])

    expect(current).to be_a(CurrentPoro)
    expect(current.datetime).to be_a(String)
    expect(current.sunrise).to be_a(String)
    expect(current.sunset).to be_a(String)
    expect(current.temperature).to be_a(Float)
    expect(current.feels_like).to be_a(Float)
    expect(current.humidity).to be_a(Integer)
    expect(current.uvi).to be_a(Numeric)
    expect(current.visibility).to be_a(Integer)
    expect(current.conditions).to be_a(String)
    expect(current.icon).to be_a(String)
  end
end
