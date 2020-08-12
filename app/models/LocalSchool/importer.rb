class LocalSchool::Importer
    attr_reader :local_schools

    def initialize(local_schools:)
        @local_schools  = local_schools
        # so we can easily pass around the city to different methods
        @city           = nil
    end

    def save_all
        local_schools
        total_schools_count = local_schools.count
        puts "** total local schools: #{total_schools_count} **" 

        count_tracker = 0
        local_schools.each do |local_school|
            count_tracker += 1
            puts "local_school location #{local_school.school_name}"
            school                                      = _initialize_school(local_school)
            address                                     = " , #{local_school.city}, #{local_school.state_abbr}" 
            school.name                                 = local_school.school_name
            school.schooldigger_link                    = local_school.link_href
            parsed_address                              =  _parse_address(address)
            school.street_one                           = parsed_address[:street_one]
            school.street_two                           = ""
            school.city                                 = @city || _find_city(address)
            school.kind                                 = local_school.type
            school.grades                               = local_school.grades
            school.district                             = local_school.district
            school.schooldigger_district_link           = local_school.district_link
            school.enrollment                           = local_school.enrollment
            school.student_teacher_ratio                = local_school.student_teacher_ratio
            school.free_discounted_lunch_recipients     = local_school.free_discounted_lunch_recipients
            school.school_digger_rating                 = local_school.school_digger_rating
            school.schooldigger_id                      = local_school.school_id
            school.school_digger_rating                 = local_school.school_digger_rating

            if school.save
                @city.school_digger_scan_done = count_tracker/total_schools_count
                @city.save
            end

            # <LocalSchool::ResponseFormatter::SearchResult link_href="https://www.schooldigger.com/go/CA/schools/2046002470/school.aspx", school_id="s062046002470", school_name="Vallemar Elementary", type="Public", grades="K-8", district="Pacifica", district_link="https://www.schooldigger.com/go/CA/district/20460/search.aspx", enrollment=514, student_teacher_ratio=25.7, free_discounted_lunch_recipients=0.161, school_digger_rating=0.855, city="Pacifica", state_abbr="CA">

            # School(id: integer, schooldigger_link: text, name: string, kind: string, grades: string, district: string, schooldigger_district_link: text, enrollment: string, student_teacher_ratio: float, free_discounted_lunch_recipients: float, school_digger_rating: float, schooldigger_id: string, created_at: datetime, updated_at: datetime, city_id: integer)
        end
    end

    def _initialize_school(local_school)
        School.where(name: local_school.school_name, district: local_school.district).first_or_initialize
    end

    def _find_city(address)
        parsed_address  = _parse_address(address)
        @city            = LocalSchool::GuaranteedCity.new.find(parsed_address.fetch(:city), parsed_address.fetch(:state_abbr))
        if @city.city_ascii == "not found"
            @city = City.find_or_initialize_by(city_ascii: "not found") do |c|
                c.state_id          = city.state_id
                c.state_name        = city.state_name
                c.county_name_all   = city.county_name_all
            end
            @city.save!
        end
        @city
    end

    def _parse_address(address)
        address_array   = address.split(", ")
        street_one  = address_array[0]
        city        = address_array[1]
        state_abbr  = address_array[2]
        {street_one: street_one, city: city, state_abbr: state_abbr}
    end


end