require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get feed" do
    get feeds_feed_url
    assert_response :success
  end

end
