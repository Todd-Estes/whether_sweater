class YelpService
  def self.find_place(params)
  # def self.find_place(params, arrival_time)
    response = self.conn.get('/v3/businesses/search?') do |f|
      f.params['location'] = params[:end]
      f.params['open_at'] = 1611073922
      f.params['categories'] = "#{params[:food]}, All"
    end
    var = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry
  end

  def self.conn
    Faraday.new('https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API']}"
    end
  end
end
