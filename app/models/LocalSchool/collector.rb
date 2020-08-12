class LocalSchool::Collector
        attr_reader :place_kind, :place_name

    def initialize(place_kind:, place_name:, place_state:)
        @place_kind     = place_kind
        @place_name     = place_name
        @place_state    = place_state
    end

    def import
        place_method = "_#{@place_kind.downcase.gsub(" ", "_")}"
        self.public_send(place_method)
    end

    def _city
        # cities = 
    end
    
    def _county
        cities = City.where(state_id: @place_state).where(county_name_all: @place_name).select(:id, :city_ascii, :state_id, :school_digger_scan_done)
        _save_city_local_schools_to_schools(cities)
    end

    def _region
        # @place_name must exist in regions array
        regions = _region_listings
        regional_key = place_name.downcase.gsub(" ", "_").to_sym
        regional_values = regions[regional_key].split(", ")
        regional_values.each do |county_name|
            puts county_name
            cities = City.where(state_id: @place_state).where(county_name_all: county_name).select(:id, :city_ascii, :state_id, :school_digger_scan_done)
            _save_city_local_schools_to_schools(cities)            
        end
    end

    def _state
        
    end

    def _save_city_local_schools_to_schools(cities)
        cities.each do |c|
            puts "city: #{c.city_ascii}, state_abbr: #{c.state_id}, school_digger_scan_done: #{c.school_digger_scan_done}"
            search          = LocalSchool::Search.new(city: c.city_ascii, state_abbr: c.state_id)
            # we will skip schools that are already scanned
            if _scan_already_completed?(c) == false
                local_schools   = search.get
                ## save_all needs help for when search has no results -- currently puts a not_available school in
                schools         = LocalSchool::Importer.new(local_schools: local_schools).save_all            
            end
        end        
    end

    def _region_listings
        {bay_area:"Alameda, Contra Costa, Marin, Napa, San Francisco, San Mateo, Santa Clara, Solano, Sonoma"}
    end

    def _scan_already_completed?(city)
        if city.school_digger_scan_done.to_d >= 1 
            done = true
        else
            done = false
        end

        done
    end

end
