require 'test_helper'

class UserDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_details_new_url
    assert_response :success
  end

end
