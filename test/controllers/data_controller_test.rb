require "test_helper"

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get data_new_url
    assert_response :success
  end
end
