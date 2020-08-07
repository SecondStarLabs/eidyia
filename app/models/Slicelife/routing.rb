class Slicelife::Routing
    def initialize
        
    end

    def get_routes
        {
            search: {
                method: "get",
                path: "/shop/search"
            },
            shop: {
                method: "get",
                path: "/restaurants"
            }
        }
    end
end