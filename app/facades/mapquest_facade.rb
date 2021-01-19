class MapquestFacade
  def self.get_trip(params)
    MapquestService.trip_results(params)
##THIS NEEDS REMOVING MAYBE??
    end
  end
