# frozen_string_literal: true

require 'representable/json/collection'
class LocalSchool::Doppelganger::SearchResultRepesenter < Representable::Decorator
  include Representable::JSON

  property    :link_href
  property    :school_id
  property    :school_name
  property    :type
  property    :grades
  street_one  :street_one
  zip         :zip
  property    :district
  property    :district_link
  property    :enrollment
  property    :student_teacher_ratio
  property    :free_discounted_lunch_recipients
  property    :school_digger_rating
end
