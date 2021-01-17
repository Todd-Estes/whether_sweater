class BackgroundService

  def self.get_image(params)
    response = self.conn.get('/v7.0/images/search?') do |f|
      f.params['q'] = params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.bing.microsoft.com') do |f|
      f.headers['Ocp-Apim-Subscription-Key'] = ENV['AZURE_API']
    end
  end
end
