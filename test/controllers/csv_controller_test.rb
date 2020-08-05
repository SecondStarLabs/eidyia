require 'test_helper'

class CsvControllerTest < ActionDispatch::IntegrationTest
  test "should get import" do
    get csv_import_url
    assert_response :success
  end

end
