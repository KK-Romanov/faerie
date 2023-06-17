require "test_helper"

class ReviewControllerTest < ActionDispatch::IntegrationTest
  test "should get createdestroy" do
    get review_createdestroy_url
    assert_response :success
  end
end
