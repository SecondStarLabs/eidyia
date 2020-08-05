require 'test_helper'

class EateriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @eatery = eateries(:one)
  end

  test "should get index" do
    get eateries_url
    assert_response :success
  end

  test "should get new" do
    get new_eatery_url
    assert_response :success
  end

  test "should create eatery" do
    assert_difference('Eatery.count') do
      post eateries_url, params: { eatery: { address: @eatery.address, city_id: @eatery.city_id, delivery.decimal: @eatery.delivery.decimal, max_wait: @eatery.max_wait, min_wait: @eatery.min_wait, name: @eatery.name, no_of_reviews: @eatery.no_of_reviews, rating.decimal: @eatery.rating.decimal, street_one: @eatery.street_one, street_two: @eatery.street_two } }
    end

    assert_redirected_to eatery_url(Eatery.last)
  end

  test "should show eatery" do
    get eatery_url(@eatery)
    assert_response :success
  end

  test "should get edit" do
    get edit_eatery_url(@eatery)
    assert_response :success
  end

  test "should update eatery" do
    patch eatery_url(@eatery), params: { eatery: { address: @eatery.address, city_id: @eatery.city_id, delivery.decimal: @eatery.delivery.decimal, max_wait: @eatery.max_wait, min_wait: @eatery.min_wait, name: @eatery.name, no_of_reviews: @eatery.no_of_reviews, rating.decimal: @eatery.rating.decimal, street_one: @eatery.street_one, street_two: @eatery.street_two } }
    assert_redirected_to eatery_url(@eatery)
  end

  test "should destroy eatery" do
    assert_difference('Eatery.count', -1) do
      delete eatery_url(@eatery)
    end

    assert_redirected_to eateries_url
  end
end
