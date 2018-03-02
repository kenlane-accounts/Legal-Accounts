require 'test_helper'

class TranheadsControllerTest < ActionController::TestCase
  setup do
    @tranhead = tranheads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tranheads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tranhead" do
    assert_difference('Tranhead.count') do
      post :create, tranhead: { trdate: @tranhead.trdate, trref: @tranhead.trref }
    end

    assert_redirected_to tranhead_path(assigns(:tranhead))
  end

  test "should show tranhead" do
    get :show, id: @tranhead
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tranhead
    assert_response :success
  end

  test "should update tranhead" do
    patch :update, id: @tranhead, tranhead: { trdate: @tranhead.trdate, trref: @tranhead.trref }
    assert_redirected_to tranhead_path(assigns(:tranhead))
  end

  test "should destroy tranhead" do
    assert_difference('Tranhead.count', -1) do
      delete :destroy, id: @tranhead
    end

    assert_redirected_to tranheads_path
  end
end
