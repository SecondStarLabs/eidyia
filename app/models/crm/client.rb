class Crm::Client
    KEY             = Rails.application.credentials.dig(:hubspot)[:access_key_id]

    attr_reader :key

    def initialize(key: KEY)
        @key     = key
    end

    def api_methods
        
    end
end
