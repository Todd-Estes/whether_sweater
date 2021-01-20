require 'rails_helper'

describe 'Forecast Poro', :vcr do
  it "exists" do
    location = 'denver,co'
    forecast = ForecastFacade.get_weather(location)
    expect(forecast).to be_a(Forecast)
    expect(forecast.id).to eq(nil)
    expect(forecast.current_weather).to be_a(CurrentPoro)
    expect(forecast.daily_weather).to be_a(Array)
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.daily_weather.first).to be_a(Daily)
    expect(forecast.hourly_weather).to be_a(Array)
    expect(forecast.hourly_weather.count).to eq(8)
    expect(forecast.hourly_weather.first).to be_a(Hourly)
  end
end
