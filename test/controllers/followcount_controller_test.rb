require 'test_helper'

class FollowcountControllerTest < ActionDispatch::IntegrationTest
  test "should get follow" do
    get followcount_follow_url
    assert_response :success
  end

  test "should get unfollow" do
    get followcount_unfollow_url
    assert_response :success
  end

end
