json.extract! eatery, :id, :name, :rating.decimal, :no_of_reviews, :address, :street_one, :street_two, :city_id, :min_wait, :max_wait, :delivery.decimal, :created_at, :updated_at
json.url eatery_url(eatery, format: :json)
