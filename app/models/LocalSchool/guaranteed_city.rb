class LocalSchool::GuaranteedCity
    # def initialize
        
    # end
        #  city           = Slicelife::GuaranteedCity.new.find(city:  parsed_address.fetch(:city), state_abbr: parsed_address.fetch(:state_abbr))
    def find(city, state_abbr)
        city = City.where(city_ascii: city).where(state_id: state_abbr).first || LocalSchool::MissingCity.new
    end

end