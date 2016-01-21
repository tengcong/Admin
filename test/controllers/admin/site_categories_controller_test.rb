require 'test_helper'

class Admin::SiteCategoriesControllerTest < ActionController::TestCase
  setup do
    @admin_site_category = admin_site_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_site_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_site_category" do
    assert_difference('Admin::SiteCategory.count') do
      post :create, admin_site_category: {  }
    end

    assert_redirected_to admin_site_category_path(assigns(:admin_site_category))
  end

  test "should show admin_site_category" do
    get :show, id: @admin_site_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_site_category
    assert_response :success
  end

  test "should update admin_site_category" do
    patch :update, id: @admin_site_category, admin_site_category: {  }
    assert_redirected_to admin_site_category_path(assigns(:admin_site_category))
  end

  test "should destroy admin_site_category" do
    assert_difference('Admin::SiteCategory.count', -1) do
      delete :destroy, id: @admin_site_category
    end

    assert_redirected_to admin_site_categories_path
  end
end
