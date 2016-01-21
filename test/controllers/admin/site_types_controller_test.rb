require 'test_helper'

class Admin::SiteTypesControllerTest < ActionController::TestCase
  setup do
    @admin_site_type = admin_site_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_site_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_site_type" do
    assert_difference('Admin::SiteType.count') do
      post :create, admin_site_type: {  }
    end

    assert_redirected_to admin_site_type_path(assigns(:admin_site_type))
  end

  test "should show admin_site_type" do
    get :show, id: @admin_site_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_site_type
    assert_response :success
  end

  test "should update admin_site_type" do
    patch :update, id: @admin_site_type, admin_site_type: {  }
    assert_redirected_to admin_site_type_path(assigns(:admin_site_type))
  end

  test "should destroy admin_site_type" do
    assert_difference('Admin::SiteType.count', -1) do
      delete :destroy, id: @admin_site_type
    end

    assert_redirected_to admin_site_types_path
  end
end
