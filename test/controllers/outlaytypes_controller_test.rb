require 'test_helper'

class OutlaytypesControllerTest < ActionController::TestCase
  setup do
    @outlaytype = outlaytypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlaytypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlaytype" do
    assert_difference('Outlaytype.count') do
      post :create, outlaytype: { outcode: @outlaytype.outcode, outdesc: @outlaytype.outdesc }
    end

    assert_redirected_to outlaytype_path(assigns(:outlaytype))
  end

  test "should show outlaytype" do
    get :show, id: @outlaytype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outlaytype
    assert_response :success
  end

  test "should update outlaytype" do
    patch :update, id: @outlaytype, outlaytype: { outcode: @outlaytype.outcode, outdesc: @outlaytype.outdesc }
    assert_redirected_to outlaytype_path(assigns(:outlaytype))
  end

  test "should destroy outlaytype" do
    assert_difference('Outlaytype.count', -1) do
      delete :destroy, id: @outlaytype
    end

    assert_redirected_to outlaytypes_path
  end
end
