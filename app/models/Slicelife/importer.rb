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
                city: City.last
            )
            eatery.save!
        end
    end

end