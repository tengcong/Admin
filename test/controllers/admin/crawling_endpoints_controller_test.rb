require 'test_helper'

class Admin::CrawlingEndpointsControllerTest < ActionController::TestCase
  setup do
    @admin_crawling_endpoint = admin_crawling_endpoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_crawling_endpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_crawling_endpoint" do
    assert_difference('Admin::CrawlingEndpoint.count') do
      post :create, admin_crawling_endpoint: {  }
    end

    assert_redirected_to admin_crawling_endpoint_path(assigns(:admin_crawling_endpoint))
  end

  test "should show admin_crawling_endpoint" do
    get :show, id: @admin_crawling_endpoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_crawling_endpoint
    assert_response :success
  end

  test "should update admin_crawling_endpoint" do
    patch :update, id: @admin_crawling_endpoint, admin_crawling_endpoint: {  }
    assert_redirected_to admin_crawling_endpoint_path(assigns(:admin_crawling_endpoint))
  end

  test "should destroy admin_crawling_endpoint" do
    assert_difference('Admin::CrawlingEndpoint.count', -1) do
      delete :destroy, id: @admin_crawling_endpoint
    end

    assert_redirected_to admin_crawling_endpoints_path
  end
end
