class Crm::SliceLifeImporter
    attr_reader :crm_company
    
    def initialize(crm_company: Crm::Company.new)
        @crm_company    = crm_company
    end

    def upload(eatery)
        e   = eatery
        e_hash = {name: e.name, properties: {address: e.street_one, city: e.city.city_ascii, state: e.city.state_id}}
        crm_company.create(e_hash[:name], e_hash[:properties])
    end

    def bulk_upload(eateries)
        eateries.each do |eatery|
            e   = eatery
            e_hash = {name: e.name, properties: {address: e.street_one, city: e.city.city_ascii, state: e.city.state_id}}
            crm_company.create(e_hash[:name], e_hash[:properties])
        end        
    end

    def bulk_update(eateries)
        
    end
end