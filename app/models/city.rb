class City < ApplicationRecord
    has_many :eateries
    has_many :schools
end
