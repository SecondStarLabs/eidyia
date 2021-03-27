require 'hubspot-ruby' # the gem we are using
class Crm::Connection
    attr_reader :crm_service, :connection

    def initialize(options={})
        @connection  = self.class
    end

    def get(relative_path, query={})
        relative_path = add_api_version(relative_path)
        connection.get relative_path, query: @query.merge(query)
    end

    def activate_service(api_key: api_key)
        Hubspot.configure({
            hapikey: api_key,
            logger: Logger.new(nil),
            read_timeout: nil, # or :timeout to set read_timeout and open_timeout
            open_timeout: nil
        })
        @crm_service = Hubspot
    end
end
