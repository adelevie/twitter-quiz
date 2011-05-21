require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get twitter_logout" do
    get :twitter_logout
    assert_response :success
  end

end
