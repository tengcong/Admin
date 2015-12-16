require 'test_helper'

class BqPackagesControllerTest < ActionController::TestCase
  setup do
    @bq_package = bq_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bq_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bq_package" do
    assert_difference('BqPackage.count') do
      post :create, bq_package: {  }
    end

    assert_redirected_to bq_package_path(assigns(:bq_package))
  end

  test "should show bq_package" do
    get :show, id: @bq_package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bq_package
    assert_response :success
  end

  test "should update bq_package" do
    patch :update, id: @bq_package, bq_package: {  }
    assert_redirected_to bq_package_path(assigns(:bq_package))
  end

  test "should destroy bq_package" do
    assert_difference('BqPackage.count', -1) do
      delete :destroy, id: @bq_package
    end

    assert_redirected_to bq_packages_path
  end
end
