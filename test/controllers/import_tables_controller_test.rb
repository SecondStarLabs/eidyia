require 'test_helper'

class ImportTablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @import_table = import_tables(:one)
  end

  test "should get index" do
    get import_tables_url
    assert_response :success
  end

  test "should get new" do
    get new_import_table_url
    assert_response :success
  end

  test "should create import_table" do
    assert_difference('ImportTable.count') do
      post import_tables_url, params: { import_table: { original_path: @import_table.original_path } }
    end

    assert_redirected_to import_table_url(ImportTable.last)
  end

  test "should show import_table" do
    get import_table_url(@import_table)
    assert_response :success
  end

  test "should get edit" do
    get edit_import_table_url(@import_table)
    assert_response :success
  end

  test "should update import_table" do
    patch import_table_url(@import_table), params: { import_table: { original_path: @import_table.original_path } }
    assert_redirected_to import_table_url(@import_table)
  end

  test "should destroy import_table" do
    assert_difference('ImportTable.count', -1) do
      delete import_table_url(@import_table)
    end

    assert_redirected_to import_tables_url
  end
end
