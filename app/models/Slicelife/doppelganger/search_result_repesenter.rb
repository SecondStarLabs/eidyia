# frozen_string_literal: true

require 'representable/json/collection'
class Slicelife::Doppelganger::SearchResultRepesenter < Representable::Decorator
  include Representable::JSON

  # => {"classifiers"=>[{"classifier_id"=>"cars_vs_trucks_1038738999", "name"=>"cars_vs_trucks", "status"=>"ready"}, {"classifier_id"=>"WomensProfessionalWear410_195804125", "name"=>"Womens Professional Wear 410", "status"=>"ready"}, {"classifier_id"=>"blouse_397319545", "name"=>"blouse", "status"=>"ready"}, {"classifier_id"=>"CasualDresses_1840788233", "name"=>"Casual Dresses", "status"=>"ready"}, {"classifier_id"=>"blouse_1679128714", "name"=>"blouse", "status"=>"ready"}, {"classifier_id"=>"dress_937454289", "name"=>"dress", "status"=>"ready"}, {"classifier_id"=>"blouse_420760674", "name"=>"blouse", "status"=>"ready"}, {"classifier_id"=>"CarsvsTrucks_1384454315", "name"=>"Cars vs Trucks", "status"=>"ready"}, {"classifier_id"=>"casualClothes_456311891", "name"=>"casualClothes", "status"=>"ready"}, {"classifier_id"=>"CarsvsTrucks_550135472", "name"=>"Cars vs Trucks", "status"=>"ready"}, {"classifier_id"=>"dogstoday_753283156", "name"=>"dogstoday", "status"=>"ready"}, {"classifier_id"=>"jewelry_1228174860", "name"=>"jewelry", "status"=>"ready"}, {"classifier_id"=>"pants_1872568473", "name"=>"pants", "status"=>"ready"}, {"classifier_id"=>"CarsvsTrucks_212332433", "name"=>"Cars vs Trucks", "status"=>"ready"}, {"classifier_id"=>"dress_918126901", "name"=>"dress", "status"=>"ready"}, {"classifier_id"=>"cars_1664524096", "name"=>"cars", "status"=>"ready"}, {"classifier_id"=>"other_607615848", "name"=>"other", "status"=>"ready"}, {"classifier_id"=>"dogs_142356762", "name"=>"dogs", "status"=>"ready"}, {"classifier_id"=>"shoe_1951404483", "name"=>"shoe", "status"=>"ready"}, {"classifier_id"=>"dress_871132214", "name"=>"dress", "status"=>"ready"}]}
  #  yes, I know, images property lives here too, but that is handled
  #  differently for now.

  property :link_href
  property :img_src
  property :location_name
  property :location_rating
  property :no_reviews
  property :address
  property :city
  property :state_abbr
  property :order_minimum
  property :order_minimum_low
  property :order_minimum_high
  property :wait_time
  property :min_wait_time
  property :max_wait_time
  property :delivery
  property :subscribed
end