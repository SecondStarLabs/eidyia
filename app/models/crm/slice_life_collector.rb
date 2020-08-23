class Crm::SliceLifeCollector
    def initialize(crm_company: Crm::Company.new, place_kind:, place_name:, place_state:)
        @place_kind     = place_kind
        @place_name     = place_name
        @place_state    = place_state
        @crm_company    = crm_company

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
        _save_city_shops_to_crm(cities)
    end

    def _state
        
    end

    def _save_city_shops_to_crm(cities)
        ##! to do:  ternary to update the ones that are already imported 
        ##!         and create the ones that are not (2 supporting methods)
        companies       = crm_company.all
        crm_eateries    = cos.map {|c| OpenStruct.new({id: c.vid, 
                        name: c.name, 
                        address: c.properties[:address], 
                        city: c.properties[:city], 
                        state: c.properties[:state]})}

        cities.each do |c|
            puts "city: #{c.city_ascii}, state_abbr: #{c.state_id}"
            local_crm_eateries = cm.find_all {|crm_eatery| crm_eatery.city == c.city && crm_eatery.state == "CA"}
            local_eateries = Eatery.where("city_id = ?", c.id)
            ## save_all needs help for when search has no results
            sli = Crm::SliceLifeImporter.new
            sli.bulk_upload(local_eateries)
        end        
    end

end
