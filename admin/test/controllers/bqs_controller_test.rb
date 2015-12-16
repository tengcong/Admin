require 'test_helper'

class BqsControllerTest < ActionController::TestCase
  setup do
    @bq = bqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bq" do
    assert_difference('Bq.count') do
      post :create, bq: {  }
    end

    assert_redirected_to bq_path(assigns(:bq))
  end

  test "should show bq" do
    get :show, id: @bq
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bq
    assert_response :success
  end

  test "should update bq" do
    patch :update, id: @bq, bq: {  }
    assert_redirected_to bq_path(assigns(:bq))
  end

  test "should destroy bq" do
    assert_difference('Bq.count', -1) do
      delete :destroy, id: @bq
    end

    assert_redirected_to bqs_path
  end
end
