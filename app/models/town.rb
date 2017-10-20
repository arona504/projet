class Town < ActiveRecord::Base
    before_validation :load_position

  private
  def load_position

    places = Nominatim.search(name).limit(1)
      if places.first

    self.lat = places.first.lat

    self.lon = places.first.lon
      end

  end
  
  public 
    def get_weather_data
      forcecastIO.forecast(self.lat, self.lon)
    end
end
