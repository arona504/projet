class Town < ActiveRecord::Base
   before_validation :load_position
	 validates :lat, :lon, presence: true 
	public
	def load_position
    places = Nominatim.search(name).limit(1)
		if places.first
    	self.lat = places.first.lat
    	self.lon = places.first.lon
		end
  end
	 
end
