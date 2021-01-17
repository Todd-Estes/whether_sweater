class BackgroundsFacade

  def self.get_background(location)
    photo_data = BackgroundService.get_image(location)
    var = BackgroundImage.new(photo_data[:value][0], location)
  end
end
