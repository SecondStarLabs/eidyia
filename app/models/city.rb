class City < ApplicationRecord
    has_many :eateries
    has_many :schools

    scope :bay_area, -> { where(:county_name_all => ["Alameda", "Contra Costa", "Marin", "Napa", "San Francisco", "San Mateo", "Santa Clara", "Solano", "Sonoma"])}
end
