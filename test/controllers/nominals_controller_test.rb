require 'test_helper'

class NominalsControllerTest < ActionController::TestCase
  setup do
    @nominal = nominals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nominals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nominal" do
    assert_difference('Nominal.count') do
      post :create, nominal: { code: @nominal.code, desc: @nominal.desc, isclient: @nominal.isclient, isdeposit: @nominal.isdeposit, isoffice: @nominal.isoffice }
    end

    assert_redirected_to nominal_path(assigns(:nominal))
  end

  test "should show nominal" do
    get :show, id: @nominal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nominal
    assert_response :success
  end

  test "should update nominal" do
    patch :update, id: @nominal, nominal: { code: @nominal.code, desc: @nominal.desc, isclient: @nominal.isclient, isdeposit: @nominal.isdeposit, isoffice: @nominal.isoffice }
    assert_redirected_to nominal_path(assigns(:nominal))
  end

  test "should destroy nominal" do
    assert_difference('Nominal.count', -1) do
      delete :destroy, id: @nominal
    end

    assert_redirected_to nominals_path
  end
end
