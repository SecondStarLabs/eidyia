require 'watir'
require 'webdrivers'
require 'uri'

class Slicelife::Connection
    # def initialize(city: "San Francisco", state_abbr: "CA", shop: nil)
    #     @city           = city
    #     @state_abbr     = state_abbr
    #     @shop           = shop
    # end

  DEFAULT_API_VERSION = "1"
  DEFAULT_BASE_URI    = 'https://slicelife.com'
  DEFAULT_QUERY       = {}
      
    attr_reader :api_version, :query, :connection, :base_uri

    def initialize(api_version: DEFAULT_API_VERSION, query: DEFAULT_QUERY, base_uri: DEFAULT_BASE_URI)
        @api_version = api_version
        @query       = query
        @connection  = self.class
        @base_uri    = base_uri
    end

    def query(params={})
        @query.update(params)
    end    

    def get(relative_path, query={})
        @has_seach_results = true
        puts "relative_path: #{relative_path}, query=#{@query.merge(query)} "
        #\            call the connection for records
    # connection.send(http_method, relative_path, *request_arguments)

        # relative_path = _add_api_version(relative_path)
        url = [@base_uri, relative_path, "?", @query.merge(query).to_query].join("")
        # url = [url, query.to_query]
        puts url

        browser = Watir::Browser.new
        browser.goto(url)
            
        #     # 'https://slicelife.com/shop/search?search_shipping_type_filter=either&address=San%20Francisco,%20CA,%20USA')

        puts browser.title

        # wait and capture test results if they exist
        begin
            js_doc  = browser.div(class: /_8mjm61/).wait_until(timeout = 10, &:present?)
        rescue
            puts "waited more than three seconds without seeing search results"
            @has_search_results = false
            js_doc  = browser.div(id: /app/)

            @doc     = Nokogiri::HTML.parse(js_doc.inner_html)
            puts "### Failure, shops not found"
            puts "======"
        
        end
        
        if @has_search_results != false
            js_doc  = browser.div(class: /_8mjm61/).wait_until(&:present?)

            @doc     = Nokogiri::HTML.parse(js_doc.inner_html)
            puts "### Success, Search for nodes by css"
            # links_fragment = @doc.css('._1j8jxoz').first
            puts "======"
        end

        browser.close
        @doc
    end

    ################
    def _add_api_version(relative_path)
        "/#{_api_version_path}#{relative_path}"
    end

    def _api_version_path
        "v" + @api_version.to_s
    end    

    def _set_shop_relative_path
        # this method does not always work.  Probably should use url from scrape
        relative_path = ["", _state_abbr_param, _city_param, _zip_param, _shop_param, "menu"].join("/")
    end

    def _state_abbr_param
        "CA".downcase
    end

    def _city_param
        "San Francisco".downcase.gsub(" ", "-")
    end

    def _zip_param
        "94404"
    end

    def _shop_param
        "bizza"
    end

    def _generate_url
        url                         = "#{BASE_URL}?search_shipping_type_filter=#{search_shipping_type_filter}&address=#{address}"
    end


end
