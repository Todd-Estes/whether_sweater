class WeatherService

  def self.get_forecast(params)
    response = self.conn.get('/data/2.5/onecall?') do |f|
      f.params[:lat] = params[:lat]
      f.params[:lon] = params[:lng]
    end
    var = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org') do |f|
      f.params[:appid] = ENV['WEATHER_API']
    end
  end
end
