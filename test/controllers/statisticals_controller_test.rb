require 'test_helper'

class StatisticalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get statisticals_index_url
    assert_response :success
  end

end
