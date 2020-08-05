require "application_system_test_case"

class CitiesTest < ApplicationSystemTestCase
  setup do
    @city = cities(:one)
  end

  test "visiting the index" do
    visit cities_url
    assert_selector "h1", text: "Cities"
  end

  test "creating a City" do
    visit cities_url
    click_on "New City"

    fill_in "City ascii", with: @city.city_ascii
    fill_in "County fips", with: @city.county_fips
    fill_in "County fips all", with: @city.county_fips_all
    fill_in "County name all", with: @city.county_name_all
    fill_in "Density", with: @city.density
    check "Incorporated" if @city.incorporated
    fill_in "Lat", with: @city.lat
    fill_in "Lng", with: @city.lng
    check "Military" if @city.military
    fill_in "Population", with: @city.population
    fill_in "Ranking", with: @city.ranking
    fill_in "Source", with: @city.source
    fill_in "State", with: @city.state_id
    fill_in "State name", with: @city.state_name
    fill_in "Timezone", with: @city.timezone
    fill_in "Zips", with: @city.zips
    click_on "Create City"

    assert_text "City was successfully created"
    click_on "Back"
  end

  test "updating a City" do
    visit cities_url
    click_on "Edit", match: :first

    fill_in "City ascii", with: @city.city_ascii
    fill_in "County fips", with: @city.county_fips
    fill_in "County fips all", with: @city.county_fips_all
    fill_in "County name all", with: @city.county_name_all
    fill_in "Density", with: @city.density
    check "Incorporated" if @city.incorporated
    fill_in "Lat", with: @city.lat
    fill_in "Lng", with: @city.lng
    check "Military" if @city.military
    fill_in "Population", with: @city.population
    fill_in "Ranking", with: @city.ranking
    fill_in "Source", with: @city.source
    fill_in "State", with: @city.state_id
    fill_in "State name", with: @city.state_name
    fill_in "Timezone", with: @city.timezone
    fill_in "Zips", with: @city.zips
    click_on "Update City"

    assert_text "City was successfully updated"
    click_on "Back"
  end

  test "destroying a City" do
    visit cities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "City was successfully destroyed"
  end
end
