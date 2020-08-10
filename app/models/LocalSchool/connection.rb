require 'watir'
require 'webdrivers'
require 'uri'

class LocalSchool::Connection
    # def initialize(city: "San Francisco", state_abbr: "CA", shop: nil)
    #     @city           = city
    #     @state_abbr     = state_abbr
    #     @shop           = shop
    # end

  DEFAULT_API_VERSION = "1"
  DEFAULT_BASE_URI    = 'https://www.schooldigger.com'
  DEFAULT_QUERY       = {}
  DEFAULT_STATE_ABBR  = 'CA'
  DEFAULT_CITY        = 'San Francisco'
      
    attr_reader :api_version, :query, :connection, :base_uri, :state_abbr, :school_id, :city

    def initialize(api_version: DEFAULT_API_VERSION, query: DEFAULT_QUERY, base_uri: DEFAULT_BASE_URI, state_abbr: , school_id: nil, city: DEFAULT_CITY)
        @api_version = api_version
        @query       = query
        @connection  = self.class
        @base_uri    = base_uri
        @state_abbr  = state_abbr
        @school_id   = school_id
        @city        = city
    end

    def query(params={})
        @query.update(params)
    end    

    def get(relative_path, query={})
        # @has_seach_results = true
        relative_path = _append_relative_path(relative_path)
        puts "relative_path: #{relative_path}, query=#{@query.merge(query)} "
        #\            call the connection for records
    # connection.send(http_method, relative_path, *request_arguments)

        # relative_path = _add_api_version(relative_path)
        url = [@base_uri, relative_path, "?", @query.merge(query).to_query].join("")
        # url = [url, query.to_query]
        puts url

        browser = Watir::Browser.new
        browser.goto(url)
            
        # https://www.schooldigger.com/go/CA/city/Pacifica/search.aspx

        puts browser.title

        # wait and capture test results if they exist
        begin
            js_doc  = browser.div(class: /bsRTable/)#.wait_until(timeout = 30, &:present?)
            
        rescue
            puts "waited more than thirty seconds without seeing search results"
            @has_search_results = false
            js_doc  = browser.body

            @doc     = Nokogiri::HTML.parse(js_doc.inner_html)
            puts "### Failure, shops not found"
            puts "======"
        
        end
        
        if @has_search_results != false
            js_doc  = browser.body.wait_until(&:present?)

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

    def _append_relative_path(relative_path)
        result = school_id.present? ?  _set_school_relative_path(relative_path) : _set_city_search_relative_path(relative_path)
    end

    def _set_school_relative_path(relative_path)
        # this method does not always work.  Probably should use url from scrape
        # https://www.schooldigger.com/go/CA/schools/3441006556/school.aspx
        [relative_path, _state_abbr_param, "schools", _school_id_param, "school.aspx"].join("/")
    end

    def _set_city_search_relative_path(relative_path)
        # this method does not always work.  Probably should use url from scrape
        # https://www.schooldigger.com/go/CA/city/San+Francisco/search.aspx
        [relative_path, _state_abbr_param, "city", _city_param, "search.aspx"].join("/")
    end

    def _state_abbr_param
        state_abbr
    end

    def _city_param
        city.gsub(" ", "+")
    end

    def _school_id_param
        school_id
    end


    def _generate_url
        url                         = "#{BASE_URL}?search_shipping_type_filter=#{search_shipping_type_filter}&address=#{address}"
    end
end
