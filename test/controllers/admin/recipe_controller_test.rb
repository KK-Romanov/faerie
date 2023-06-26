require "test_helper"

class Admin::RecipeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_recipe_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_recipe_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_recipe_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_recipe_destroy_url
    assert_response :success
  end
end
