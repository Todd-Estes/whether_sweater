class YelpFacade
  def self.get_restaurant(params)
    restaurant = YelpService.find_place(params)
  end
end
