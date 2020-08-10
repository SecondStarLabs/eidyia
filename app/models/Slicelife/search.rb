class Slicelife::Search

    ROUTES = Slicelife::Routing.new.get_routes
    attr_reader :city, :state_abbr
    def initialize(city:, state_abbr:)
        @city           = city
        @state_abbr     = state_abbr
    end

    def get
        # create a connection
        connection = Slicelife::Connection.new
        # set query params
        connection.query({address: _create_address, orderType: 'delivery'})

        client   = Slicelife::Client.new(connection: connection, routes: ROUTES)
        # response = Representation.new(client.search)
        puts "got client"
        # shop_listing_in_city = self._create_representation
        response = client.search
        puts "========="
        puts "got response #{response}"
        # parse the nokogiri object in search_results
        search_results = _parse_response(response)

        # convert search_results to a collection of instances
        representation  = _create_representation(search_results)
    end

    def _parse_response(response)
        Slicelife::PageParser::Search.new(fragment: response).parse
    end

    def _create_representation(array_of_shops)
        shops = []
        array_of_shops.each do |shop_info|
            # convert hash to an OpenStruct
            shop = Slicelife::ResponseFormatter::SearchResult.new
            Slicelife::Doppelganger::SearchResultRepesenter
                .new(shop)
                .from_json(shop_info.to_json)            
            shops << shop

        end
        shops
    end

    def _create_address
        # 'Salt Lake City, UT, USA'
        address = [city, state_abbr, "USA"].join(", ")
    end

end
