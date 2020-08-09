class Slicelife::Collector
    def initialize(place_kind:, place_name:, place_state:)
        @place_kind     = place_kind
        @place_name     = place_name
        @place_state    = place_state
    end

    def import
        place_method = "_#{@place_kind}"
        self.public_send(place_method)
    end

    def _city
        # cities = 
    end
    
    def _county
        cities = City.where(state_id: @place_state).where(county_name_all: @place_name).select(:id, :city_ascii, :state_id)
        _save_city_shops_to_eatery(cities)
    end

    def _state
        
    end

    def _save_city_shops_to_eatery(cities)
        cities.each do |c|
            puts "city: #{c.city_ascii}, state_abbr: #{c.state_id}"
            search  = Slicelife::Search.new(city: c.city_ascii, state_abbr: c.state_id)
            shops   = search.get
            ## save_all needs help for when search has no results
            eateries    = Slicelife::Importer.new(shops: shops).save_all            
        end        
    end

end
