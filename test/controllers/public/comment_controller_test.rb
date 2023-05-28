require "test_helper"

class Public::CommentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_comment_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_comment_destroy_url
    assert_response :success
  end
end
