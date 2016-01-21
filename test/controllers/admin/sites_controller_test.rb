require 'test_helper'

class Admin::SitesControllerTest < ActionController::TestCase
  setup do
    @admin_site = admin_sites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_site" do
    assert_difference('Admin::Site.count') do
      post :create, admin_site: {  }
    end

    assert_redirected_to admin_site_path(assigns(:admin_site))
  end

  test "should show admin_site" do
    get :show, id: @admin_site
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_site
    assert_response :success
  end

  test "should update admin_site" do
    patch :update, id: @admin_site, admin_site: {  }
    assert_redirected_to admin_site_path(assigns(:admin_site))
  end

  test "should destroy admin_site" do
    assert_difference('Admin::Site.count', -1) do
      delete :destroy, id: @admin_site
    end

    assert_redirected_to admin_sites_path
  end
end
