require 'test_helper'

class BqTypesControllerTest < ActionController::TestCase
  setup do
    @bq_type = bq_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bq_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bq_type" do
    assert_difference('BqType.count') do
      post :create, bq_type: {  }
    end

    assert_redirected_to bq_type_path(assigns(:bq_type))
  end

  test "should show bq_type" do
    get :show, id: @bq_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bq_type
    assert_response :success
  end

  test "should update bq_type" do
    patch :update, id: @bq_type, bq_type: {  }
    assert_redirected_to bq_type_path(assigns(:bq_type))
  end

  test "should destroy bq_type" do
    assert_difference('BqType.count', -1) do
      delete :destroy, id: @bq_type
    end

    assert_redirected_to bq_types_path
  end
end
