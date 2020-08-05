require "application_system_test_case"

class ImportTablesTest < ApplicationSystemTestCase
  setup do
    @import_table = import_tables(:one)
  end

  test "visiting the index" do
    visit import_tables_url
    assert_selector "h1", text: "Import Tables"
  end

  test "creating a Import table" do
    visit import_tables_url
    click_on "New Import Table"

    fill_in "Original path", with: @import_table.original_path
    click_on "Create Import table"

    assert_text "Import table was successfully created"
    click_on "Back"
  end

  test "updating a Import table" do
    visit import_tables_url
    click_on "Edit", match: :first

    fill_in "Original path", with: @import_table.original_path
    click_on "Update Import table"

    assert_text "Import table was successfully updated"
    click_on "Back"
  end

  test "destroying a Import table" do
    visit import_tables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Import table was successfully destroyed"
  end
end
