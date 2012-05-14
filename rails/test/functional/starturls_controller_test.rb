require 'test_helper'

class StarturlsControllerTest < ActionController::TestCase
  setup do
    @starturl = starturls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:starturls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create starturl" do
    assert_difference('Starturl.count') do
      post :create, starturl: @starturl.attributes
    end

    assert_redirected_to starturl_path(assigns(:starturl))
  end

  test "should show starturl" do
    get :show, id: @starturl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @starturl
    assert_response :success
  end

  test "should update starturl" do
    put :update, id: @starturl, starturl: @starturl.attributes
    assert_redirected_to starturl_path(assigns(:starturl))
  end

  test "should destroy starturl" do
    assert_difference('Starturl.count', -1) do
      delete :destroy, id: @starturl
    end

    assert_redirected_to starturls_path
  end
end
