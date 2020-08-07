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

        # shop_listing_in_city = self._create_representation
        client.search
    end

    def _parse_response(response)
        
    end

    def _create_representation
        
    end

    def _create_address
        # 'Salt Lake City, UT, USA'
        address = [city, state_abbr, "USA"].join(", ")
    end

end
