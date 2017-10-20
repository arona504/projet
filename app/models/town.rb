class Town < ActiveRecord::Base
   before_validation :load_position
	public
	def load_position
    places = Nominatim.search(name).limit(1)
    self.lat = places.first.lat
    self.lon = places.first.lon
  end
	
   public
  
  def forecast_io
    forecast = ForecastIO.forecast(self.lat, self.lon, params: { units: 'si' })
    results = {}
		results[:temperature] = forecast.currently.temperature
    results[:summary] = forecast.currently.summary
    results[:windSpeed] = forecast.currently.windSpeed
		results[:cloudCover] = forecast.currently.cloudCover
		results[:precipProbability] = forecast.currently.precipProbability
		results
  end
  
  
end
