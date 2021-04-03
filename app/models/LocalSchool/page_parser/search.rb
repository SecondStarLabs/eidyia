require 'nokogiri'
class LocalSchool::PageParser::Search
    def initialize(fragment: )
        @fragment = fragment
    end

    def parse
        @schools = []
        return  if !@fragment.css('#tabSchooList').present?
        # if td.dataTables_empty school_hash = _missing_school else _parse_table_rows
        if @fragment.css('#tabSchooList').css('tbody').css('tr').css('td.dataTables_empty').present?
            puts "=== !! dataTables_empty"
            school_hash = _missing_school
            puts school_hash
            @schools << school_hash
        else
            @schools = _parse_table_rows_into_hash
        end
        @schools

    end

    def _parse_address(address)
        city        = address.split(", ")[1]
        state_abbr  = address.split(", ")[2]
        {city: city, state_abbr: state_abbr}
    end


    def _missing_school
        not_available = "not_available"
        quantitiy_not_available = 0
        {
            link_href: not_available,
            school_id: not_available,
            school_name: not_available,
            type: not_available,
            grades:  not_available,
            district: not_available,
            district_link: not_available,
            enrollment: quantitiy_not_available,
            student_teacher_ratio: quantitiy_not_available,
            free_discounted_lunch_recipients: quantitiy_not_available,
            school_digger_rating: quantitiy_not_available
        }
    end

    def _parse_table_rows_into_hash
        @fragment.css('#tabSchooList').css('tbody').css('tr').each do |row|
            puts "found link"
            # puts row.css('td').css('div')
            school_div                          = row.css('td').css('div')
            link_href                           = school_div.attr('data-url').value.to_s
            puts "link_href: #{link_href} "
            school_id                           = school_div.attr('data-sid').value.to_s
            puts "school_id: #{school_id} "
            school_name                         = school_div.attr('data-sch').value.to_s
            puts "school_name: #{school_name} "
            type                                = row.css('td[2]').text
            puts "type: #{type} "
            grades                              = row.css('td[3]').text
            puts "grades: #{grades} "
            street_one                          = row.css('td[4]').text
            puts "street_one: #{street_one} "
            city                                = row.css('td[5]')
            city_text                           = city.text
            puts "city: #{city_text} "
            # city_link                           = city.attr('href').value.to_s
            # puts "city_link: #{city_link} "

            zip                                 = row.css('td[6] a')
            zip_text                            = zip.text
            puts "zip: #{zip.text} "
            zip_link                            = zip.attr('href').value.to_s
            puts "zip_link: #{zip_link} "

            county                              = row.css('td[7] a')
            county_text                         = county.text
            puts "county: #{county.text} "
            county_link                         = county.attr('href').value.to_s
            puts "county_link: #{county_link} "

            district                            = row.css('td[8] a')
            district_text                       = district.text 
            puts "district: #{district_text} "
            district_link                       = district.attr('href').value.to_s 
            puts "district_link: #{district_link} "
            
            enrollment                          = row.css('td[14]')
            enrollment_number                   = enrollment.text.to_i 
            puts "enrollment: #{enrollment_number} "

            
            student_teacher_ratio               = row.css('td[16]')
            student_teacher_ratio_number        = student_teacher_ratio.text.to_f
            puts "student_teacher_ratio: #{student_teacher_ratio_number} "

            free_discounted_lunch_recipients    = row.css('td[17]')
            free_discounted_lunch_recipients_number = free_discounted_lunch_recipients.attr('data-order').value.to_f
            puts "free_discounted_lunch_recipients: #{free_discounted_lunch_recipients_number} "

            school_digger_rating                = row.css('td[28]')
            school_digger_rating_number         = school_digger_rating.attr('data-order').value.to_f
            puts "school_digger_rating: #{school_digger_rating_number} "

            school_digger_rating                = row.css('td[28]').attr('data-order').value.to_f
            
            school_hash = {link_href: link_href, 
                school_id: school_id, 
                school_name: school_name, 
                type: type, grades: grades, 
                district: district_text, 
                district_link: district_link, 
                enrollment: enrollment_number, 
                student_teacher_ratio: student_teacher_ratio_number, free_discounted_lunch_recipients: free_discounted_lunch_recipients_number, school_digger_rating: school_digger_rating_number, 
                street_one: street_one,
                city: city_text,
                zip: zip_text
            }
            puts school_hash
            @schools << school_hash
        end
        @schools
    end
end
