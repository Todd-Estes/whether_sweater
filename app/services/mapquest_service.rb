class MapquestService
  def self.city_results(location)
    response = self.conn.get('/geocoding/v1/address?') do |f|
      f.params[:location] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.trip_results(params)
    response = self.conn.get('/directions/v1/route?') do |f|
      # f.params[:from] = "39.750307,-104.999472"
      #for ^lat, lng
      f.params[:from] = params[:origin]
      f.params[:to] = params[:destination]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end
end
