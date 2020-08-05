json.extract! city, :id, :city_ascii, :state_id, :state_name, :county_fips, :county_fips_all, :county_name_all, :lat, :lng, :population, :density, :source, :military, :incorporated, :timezone, :ranking, :zips, :created_at, :updated_at
json.url city_url(city, format: :json)
