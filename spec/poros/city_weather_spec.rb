require 'rails_helper'

describe 'CityWeather Poro' do
  it 'exists' do
    data = { lotta stuff}

    weather = CityWeather.new(data)

    expect(weather).to be_a(CityWeather)
    #test attributes here
  end
  #test sad path???
end
