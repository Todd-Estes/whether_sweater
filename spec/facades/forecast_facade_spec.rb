require "rails_helper"

describe 'Forecast Facade' do
  it 'compiles data for forecast given location data parameters' do
    location = 'austin,tx'
    forecast = ForecastFacade.get_weather(location)

    expect(forecast).to be_a(Forecast)
    expect(forecast.id).to be_nil
    expect(forecast.current_weather).to be_a(CurrentPoro)
    expect(forecast.daily_weather).to be_a(Array)
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.daily_weather.first).to be_a(Daily)
    expect(forecast.hourly_weather).to be_a(Array)
    expect(forecast.hourly_weather.count).to eq(8)
    expect(forecast.hourly_weather.first).to be_a(Hourly)
  end

  describe ".class_methods" do
    it "creates daily and hourly poros" do
      location = 'austin,tx'
      map_results = MapquestService.city_results(location)
      params = map_results[:results][0][:locations][0][:latLng]
      result = WeatherService.get_forecast(params)
      daily_poro = ForecastFacade.create_daily_poro(result[:daily][0..4])
      hourly_poro = ForecastFacade.create_hourly_poro(result[:hourly][0..7])

      expect(daily_poro).to be_a(Array)
      expect(daily_poro.first).to be_a(Daily)
      expect(hourly_poro).to be_a(Array)
      expect(hourly_poro.first).to be_a(Hourly)
    end
  end
end
