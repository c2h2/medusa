require 'test_helper'

class UasControllerTest < ActionController::TestCase
  setup do
    @ua = uas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ua" do
    assert_difference('Ua.count') do
      post :create, ua: @ua.attributes
    end

    assert_redirected_to ua_path(assigns(:ua))
  end

  test "should show ua" do
    get :show, id: @ua
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ua
    assert_response :success
  end

  test "should update ua" do
    put :update, id: @ua, ua: @ua.attributes
    assert_redirected_to ua_path(assigns(:ua))
  end

  test "should destroy ua" do
    assert_difference('Ua.count', -1) do
      delete :destroy, id: @ua
    end

    assert_redirected_to uas_path
  end
end
