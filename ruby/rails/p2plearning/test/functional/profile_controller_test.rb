require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get me" do
    get :me
    assert_response :success
  end

end
