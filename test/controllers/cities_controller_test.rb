require 'test_helper'

class CitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city = cities(:one)
  end

  test "should get index" do
    get cities_url
    assert_response :success
  end

  test "should get new" do
    get new_city_url
    assert_response :success
  end

  test "should create city" do
    assert_difference('City.count') do
      post cities_url, params: { city: { city_ascii: @city.city_ascii, county_fips: @city.county_fips, county_fips_all: @city.county_fips_all, county_name_all: @city.county_name_all, density: @city.density, incorporated: @city.incorporated, lat: @city.lat, lng: @city.lng, military: @city.military, population: @city.population, ranking: @city.ranking, source: @city.source, state_id: @city.state_id, state_name: @city.state_name, timezone: @city.timezone, zips: @city.zips } }
    end

    assert_redirected_to city_url(City.last)
  end

  test "should show city" do
    get city_url(@city)
    assert_response :success
  end

  test "should get edit" do
    get edit_city_url(@city)
    assert_response :success
  end

  test "should update city" do
    patch city_url(@city), params: { city: { city_ascii: @city.city_ascii, county_fips: @city.county_fips, county_fips_all: @city.county_fips_all, county_name_all: @city.county_name_all, density: @city.density, incorporated: @city.incorporated, lat: @city.lat, lng: @city.lng, military: @city.military, population: @city.population, ranking: @city.ranking, source: @city.source, state_id: @city.state_id, state_name: @city.state_name, timezone: @city.timezone, zips: @city.zips } }
    assert_redirected_to city_url(@city)
  end

  test "should destroy city" do
    assert_difference('City.count', -1) do
      delete city_url(@city)
    end

    assert_redirected_to cities_url
  end
end
