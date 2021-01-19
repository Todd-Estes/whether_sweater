class YelpFacade
  def self.get_restaurant(params, time)
    restaurant = YelpService.find_place(params, time)
  end
end
