require "application_system_test_case"

class InformationTest < ApplicationSystemTestCase
  setup do
    @information = information(:one)
  end

  test "visiting the index" do
    visit information_url
    assert_selector "h1", text: "Information"
  end

  test "creating a Information" do
    visit information_url
    click_on "New Information"

    fill_in "Birth", with: @information.birth
    fill_in "Daterange", with: @information.daterange
    fill_in "Deposit", with: @information.deposit
    fill_in "Indentifycard", with: @information.indentifycard
    fill_in "Name", with: @information.name
    fill_in "Note", with: @information.note
    fill_in "Permanent", with: @information.permanent
    fill_in "Phone1", with: @information.phone1
    fill_in "Phone2", with: @information.phone2
    fill_in "Placerange", with: @information.placerange
    check "Sex" if @information.sex
    fill_in "Start", with: @information.start
    click_on "Create Information"

    assert_text "Information was successfully created"
    click_on "Back"
  end

  test "updating a Information" do
    visit information_url
    click_on "Edit", match: :first

    fill_in "Birth", with: @information.birth
    fill_in "Daterange", with: @information.daterange
    fill_in "Deposit", with: @information.deposit
    fill_in "Indentifycard", with: @information.indentifycard
    fill_in "Name", with: @information.name
    fill_in "Note", with: @information.note
    fill_in "Permanent", with: @information.permanent
    fill_in "Phone1", with: @information.phone1
    fill_in "Phone2", with: @information.phone2
    fill_in "Placerange", with: @information.placerange
    check "Sex" if @information.sex
    fill_in "Start", with: @information.start
    click_on "Update Information"

    assert_text "Information was successfully updated"
    click_on "Back"
  end

  test "destroying a Information" do
    visit information_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Information was successfully destroyed"
  end
end
