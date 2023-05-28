require "test_helper"

class Public::RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_recipes_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_recipes_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_recipes_update_url
    assert_response :success
  end

  test "should get new" do
    get public_recipes_new_url
    assert_response :success
  end

  test "should get destroy" do
    get public_recipes_destroy_url
    assert_response :success
  end

  test "should get tag_search" do
    get public_recipes_tag_search_url
    assert_response :success
  end
end
