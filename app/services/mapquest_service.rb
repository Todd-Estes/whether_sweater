class MapquestService
  def self.city_results(location)
    response = self.conn.get('/geocoding/v1/address?') do |f|
      f.params[:location] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.trip_results(origin, destination)
    response = self.conn.get('/directions/v1/route?') do |f|
      f.params[:from] = origin
      f.params[:to] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end


  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end
end
