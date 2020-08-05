require "application_system_test_case"

class EateriesTest < ApplicationSystemTestCase
  setup do
    @eatery = eateries(:one)
  end

  test "visiting the index" do
    visit eateries_url
    assert_selector "h1", text: "Eateries"
  end

  test "creating a Eatery" do
    visit eateries_url
    click_on "New Eatery"

    fill_in "Address", with: @eatery.address
    fill_in "City", with: @eatery.city_id
    fill_in "Delivery.decimal", with: @eatery.delivery.decimal
    fill_in "Max wait", with: @eatery.max_wait
    fill_in "Min wait", with: @eatery.min_wait
    fill_in "Name", with: @eatery.name
    fill_in "No of reviews", with: @eatery.no_of_reviews
    fill_in "Rating.decimal", with: @eatery.rating.decimal
    fill_in "Street one", with: @eatery.street_one
    fill_in "Street two", with: @eatery.street_two
    click_on "Create Eatery"

    assert_text "Eatery was successfully created"
    click_on "Back"
  end

  test "updating a Eatery" do
    visit eateries_url
    click_on "Edit", match: :first

    fill_in "Address", with: @eatery.address
    fill_in "City", with: @eatery.city_id
    fill_in "Delivery.decimal", with: @eatery.delivery.decimal
    fill_in "Max wait", with: @eatery.max_wait
    fill_in "Min wait", with: @eatery.min_wait
    fill_in "Name", with: @eatery.name
    fill_in "No of reviews", with: @eatery.no_of_reviews
    fill_in "Rating.decimal", with: @eatery.rating.decimal
    fill_in "Street one", with: @eatery.street_one
    fill_in "Street two", with: @eatery.street_two
    click_on "Update Eatery"

    assert_text "Eatery was successfully updated"
    click_on "Back"
  end

  test "destroying a Eatery" do
    visit eateries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Eatery was successfully destroyed"
  end
end
