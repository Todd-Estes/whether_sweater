require "rails_helper"

describe 'Forecast Facade' do
  it 'returns city weather info' do
    city = 'austin,tx'
    result = ForecastFacade.get_weather(city)

    expect(result).to be_a(Hash)
    expect(result.size).to eq()
    expect(result)to be_an_instance_of(CityWeather)

  end

  #add in sad path/edge cases
end
