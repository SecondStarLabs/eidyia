class Slicelife::Importer
    attr_reader :shops

    def initialize(shops:)
        @shops = shops
    end

    def save_all
        puts shops
        shops.each do |shop|
            puts "shop location #{shop.location_name} , subscribed: #{shop.subscribed}"
            eatery = Eatery.where(address: shop.address).first_or_initialize
                eatery.name    = shop.location_name
                parsed_address            =  _parse_address(shop.address)
                eatery.street_one         = parsed_address[:street_one]
                eatery.street_two         = ""
                eatery.city               = _find_city(shop.address)
                eatery.rating             = shop.location_rating
                eatery.no_of_reviews      = shop.no_reviews
                eatery.min_wait           = shop.min_wait_time
                eatery.max_wait           = shop.max_wait_time
                eatery.delivery           = shop.delivery
                eatery.source_url         = shop.link_href                    
            eatery.save!
        end
    end

    def _find_city(address)
        parsed_address  = _parse_address(address)
        city            = Slicelife::GuaranteedCity.new.find(parsed_address.fetch(:city), parsed_address.fetch(:state_abbr))
        if city.city_ascii == "not found"
            city = City.find_or_initialize_by(city_ascii: "not found") do |c|
                c.state_id          = city.state_id
                c.state_name        = city.state_name
                c.county_name_all   = city.county_name_all
            end
            city.save!
        end
        city
    end

    def _parse_address(address)
        address_array   = address.split(", ")
        street_one  = address_array[0]
        city        = address_array[1]
        state_abbr  = address_array[2]
        {street_one: street_one, city: city, state_abbr: state_abbr}
    end


end