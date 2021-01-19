class YelpService
  def self.find_place(params, time)
  # def self.find_place(params, arrival_time)
    response = self.conn.get('/v3/businesses/search?') do |f|
      f.params['location'] = params[:end]
      f.params['open_at'] = time
      f.params['categories'] = "#{params[:food]}, All"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API']}"
    end
  end
end
