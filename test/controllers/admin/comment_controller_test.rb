require "test_helper"

class Admin::CommentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_comment_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_comment_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_comment_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_comment_destroy_url
    assert_response :success
  end
end
