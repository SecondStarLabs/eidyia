require 'csv'

namespace :import do
    desc "Import users from csv"
    task users: :environment do
        filename = File.join Rails.root, "lib/users.csv"
        table = CSV.parse(File.read(filename), headers: true)
        table.by_row.each do |row|
            p OpenStruct.new(row)
        end
        # my_instance = []
        CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
            # email, first, last = row
            p row
            p row[:email]
            p row[:first_name]
            p row[:last_name]
            # my_instance << OpenStruct.new(row)
            # User.create(email: email, first_name: first, last_name: last)
        end
        # pp my_instance
    end
    desc "Import users from csv"
    task cities: :environment do
        filename = File.join Rails.root, "lib/uscities.csv"
        CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|  
            pp "#{row[:city]}, #{row[:state_name]}" 
            city = City.where(["city_ascii = ? and state_name = ?", row[:city_ascii], row[:state_name]]).first
            if city == nil
                city = City.new(city_ascii: row[:city_ascii], state_name: row[:state_name])
                # city = City.new(state_name: row[:state_name])       
            end
            # p city
            city.state_id           = row[:state_id].to_s
            city.state_name         = row[:state_name].to_s
            city.county_fips        = row[:county_fips].to_s
            city.county_fips_all    = row[:county_fips_all].to_s
            city.county_name_all    = row[:county_name_all].to_s
            city.lat                = row[:lat].to_f
            city.lng                = row[:lng].to_f
            city.population         = row[:population].to_i
            city.density            = row[:density].to_i
            city.source             = row[:source].to_s
            city.military           = row[:military].to_s.downcase
            city.incorporated       = row[:incorporated].to_s.downcase
            city.timezone           = row[:timezone].to_s
            city.ranking            = row[:ranking].to_i
            city.zips               = row[:zips].to_s
            city.save
        end      
    end
end

# "city","city_ascii","state_id","state_name","county_fips","county_name","county_fips_all","county_name_all","lat","lng","population","density","source","military","incorporated","timezone","ranking","zips","id"
# "South Creek","South Creek","WA","Washington","53053","Pierce","53053","Pierce","46.9994","-122.3921","2500","125","polygon","FALSE","TRUE","America/Los_Angeles","3","98580 98387 98338","1840042075"

# t.string "city_ascii"
    # t.string "state_id"
    # t.string "state_name"
    # t.integer "county_fips"
    # t.integer "county_fips_all"
    # t.string "county_name_all"
    # t.float "lat"
    # t.float "lng"
    # t.integer "population"
    # t.integer "density"
    # t.string "source"
    # t.boolean "military"
    # t.boolean "incorporated"
    # t.string "timezone"
    # t.integer "ranking"
    # t.string "zips"
