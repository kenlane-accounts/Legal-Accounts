require 'test_helper'

class CasestatusesControllerTest < ActionController::TestCase
  setup do
    @casestatus = casestatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:casestatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create casestatus" do
    assert_difference('Casestatus.count') do
      post :create, casestatus: { code: @casestatus.code, description: @casestatus.description }
    end

    assert_redirected_to casestatus_path(assigns(:casestatus))
  end

  test "should show casestatus" do
    get :show, id: @casestatus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @casestatus
    assert_response :success
  end

  test "should update casestatus" do
    patch :update, id: @casestatus, casestatus: { code: @casestatus.code, description: @casestatus.description }
    assert_redirected_to casestatus_path(assigns(:casestatus))
  end

  test "should destroy casestatus" do
    assert_difference('Casestatus.count', -1) do
      delete :destroy, id: @casestatus
    end

    assert_redirected_to casestatuses_path
  end
end
