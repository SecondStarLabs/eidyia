class LocalSchool::Search

    ROUTES = LocalSchool::Routing.new.get_routes
    attr_reader :city, :state_abbr
    def initialize(city:, state_abbr:)
        @city           = city
        @state_abbr     = state_abbr
    end

    def get
        # create a connection
        connection = LocalSchool::Connection.new(city: @city, state_abbr: @state_abbr)
        # set query params
        connection.query({})

        client   = LocalSchool::Client.new(connection: connection, routes: ROUTES)
        # response = Representation.new(client.search)
        puts "got client"
        # shop_listing_in_city = self._create_representation
        response = client.search
        puts "========="
        puts "got response #{response}"
        # # parse the nokogiri object in search_results
        search_results = _parse_response(response)

        # # convert search_results to a collection of instances
        # representation  = _create_representation(search_results)
    end

    def _parse_response(response)
        LocalSchool::PageParser::Search.new(fragment: response).parse
    end

    def _create_representation(array_of_shops)
        schools = []
        array_of_schools.each do |school_info|
            # convert hash to an OpenStruct
            school = LocalSchool::ResponseFormatter::SearchResult.new
            LocalSchool::Doppelganger::SearchResultRepesenter
                .new(school)
                .from_json(school_info.to_json)            
            schools << school

        end
        schools
    end

    # def _create_address
    #     # 'Salt Lake City, UT, USA'
    #     address = [city, state_abbr, "USA"].join(", ")
    # end

end
