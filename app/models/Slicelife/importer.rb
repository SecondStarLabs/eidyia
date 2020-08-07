class Slicelife::Importer
    attr_reader :shops

    def initialize(shops:)
        @shops = shops
    end

    def save_all
        shops.each do |shop|
            puts "shop location #{shop.location_name} "
            eatery = Eatery.new(name: shop.location_name,
                rating:         shop.location_rating,
                no_of_reviews:  shop.no_reviews,
                address:        shop.address,
                street_one:     shop.address,
                street_two:     shop.street_two,
                min_wait:       shop.min_wait_time,
                max_wait:       shop.max_wait_time,
                delivery:       shop.delivery,                
                source_url:     shop.link_href,
                city:           _find_city(shop.address)
            )
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
        city        = address.split(", ")[1]
        state_abbr  = address.split(", ")[2]
        {city: city, state_abbr: state_abbr}
    end


end