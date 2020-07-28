require 'test_helper'

class InformationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @information = information(:one)
  end

  test "should get index" do
    get information_index_url
    assert_response :success
  end

  test "should get new" do
    get new_information_url
    assert_response :success
  end

  test "should create information" do
    assert_difference('Information.count') do
      post information_index_url, params: { information: { birth: @information.birth, daterange: @information.daterange, deposit: @information.deposit, indentifycard: @information.indentifycard, name: @information.name, note: @information.note, permanent: @information.permanent, phone1: @information.phone1, phone2: @information.phone2, placerange: @information.placerange, sex: @information.sex, start: @information.start } }
    end

    assert_redirected_to information_url(Information.last)
  end

  test "should show information" do
    get information_url(@information)
    assert_response :success
  end

  test "should get edit" do
    get edit_information_url(@information)
    assert_response :success
  end

  test "should update information" do
    patch information_url(@information), params: { information: { birth: @information.birth, daterange: @information.daterange, deposit: @information.deposit, indentifycard: @information.indentifycard, name: @information.name, note: @information.note, permanent: @information.permanent, phone1: @information.phone1, phone2: @information.phone2, placerange: @information.placerange, sex: @information.sex, start: @information.start } }
    assert_redirected_to information_url(@information)
  end

  test "should destroy information" do
    assert_difference('Information.count', -1) do
      delete information_url(@information)
    end

    assert_redirected_to information_index_url
  end
end
