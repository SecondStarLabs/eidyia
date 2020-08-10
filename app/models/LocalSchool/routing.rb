class LocalSchool::Routing
    def initialize
        
    end

    def get_routes
        {
            search: {
                method: "get",
                path: "/go"
            },
            school: {
                method: "get",
                path: "/go"
            }
        }
    end
end