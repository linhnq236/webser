require 'test_helper'

class PaytherentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paytherent = paytherents(:one)
  end

  test "should get index" do
    get paytherents_url
    assert_response :success
  end

  test "should get new" do
    get new_paytherent_url
    assert_response :success
  end

  test "should create paytherent" do
    assert_difference('Paytherent.count') do
      post paytherents_url, params: { paytherent: { receivedate: @paytherent.receivedate, senddate: @paytherent.senddate, status: @paytherent.status } }
    end

    assert_redirected_to paytherent_url(Paytherent.last)
  end

  test "should show paytherent" do
    get paytherent_url(@paytherent)
    assert_response :success
  end

  test "should get edit" do
    get edit_paytherent_url(@paytherent)
    assert_response :success
  end

  test "should update paytherent" do
    patch paytherent_url(@paytherent), params: { paytherent: { receivedate: @paytherent.receivedate, senddate: @paytherent.senddate, status: @paytherent.status } }
    assert_redirected_to paytherent_url(@paytherent)
  end

  test "should destroy paytherent" do
    assert_difference('Paytherent.count', -1) do
      delete paytherent_url(@paytherent)
    end

    assert_redirected_to paytherents_url
  end
end
