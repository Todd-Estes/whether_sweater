class Munchie
  attr_reader :id, :destination_city, :travel_time, :forecast, :restaurant

  def initialize(restaurant_info, eta_weather, params, travel_time)
    @id = nil
    @destination_city = params[:end]
    @travel_time = Time.at(travel_time).utc.strftime("%H:%M")
    @forecast = {
          summary: eta_weather.conditions,
          temperature: eta_weather.temperature.to_s
          }
    @restaurant = {
          name: restaurant_info[:businesses][0][:name],
          address: restaurant_info[:businesses][0][:location][:display_address][0]
        }
  end
end
