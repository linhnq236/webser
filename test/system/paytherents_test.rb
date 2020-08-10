require "application_system_test_case"

class PaytherentsTest < ApplicationSystemTestCase
  setup do
    @paytherent = paytherents(:one)
  end

  test "visiting the index" do
    visit paytherents_url
    assert_selector "h1", text: "Paytherents"
  end

  test "creating a Paytherent" do
    visit paytherents_url
    click_on "New Paytherent"

    fill_in "Receivedate", with: @paytherent.receivedate
    fill_in "Senddate", with: @paytherent.senddate
    fill_in "Status", with: @paytherent.status
    click_on "Create Paytherent"

    assert_text "Paytherent was successfully created"
    click_on "Back"
  end

  test "updating a Paytherent" do
    visit paytherents_url
    click_on "Edit", match: :first

    fill_in "Receivedate", with: @paytherent.receivedate
    fill_in "Senddate", with: @paytherent.senddate
    fill_in "Status", with: @paytherent.status
    click_on "Update Paytherent"

    assert_text "Paytherent was successfully updated"
    click_on "Back"
  end

  test "destroying a Paytherent" do
    visit paytherents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Paytherent was successfully destroyed"
  end
end
