require 'test_helper'

class ClientstatusesControllerTest < ActionController::TestCase
  setup do
    @clientstatus = clientstatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clientstatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clientstatus" do
    assert_difference('Clientstatus.count') do
      post :create, clientstatus: { code: @clientstatus.code, description: @clientstatus.description }
    end

    assert_redirected_to clientstatus_path(assigns(:clientstatus))
  end

  test "should show clientstatus" do
    get :show, id: @clientstatus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clientstatus
    assert_response :success
  end

  test "should update clientstatus" do
    patch :update, id: @clientstatus, clientstatus: { code: @clientstatus.code, description: @clientstatus.description }
    assert_redirected_to clientstatus_path(assigns(:clientstatus))
  end

  test "should destroy clientstatus" do
    assert_difference('Clientstatus.count', -1) do
      delete :destroy, id: @clientstatus
    end

    assert_redirected_to clientstatuses_path
  end
end
