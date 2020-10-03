require 'test_helper'

class AppsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get apps_new_url
    assert_response :success
  end

end
