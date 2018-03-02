require 'test_helper'

class NomtransControllerTest < ActionController::TestCase
  setup do
    @nomtran = nomtrans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nomtrans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nomtran" do
    assert_difference('Nomtran.count') do
      post :create, nomtran: { amount: @nomtran.amount, date: @nomtran.date, nominal_id: @nomtran.nominal_id, tran_id: @nomtran.tran_id, type: @nomtran.type }
    end

    assert_redirected_to nomtran_path(assigns(:nomtran))
  end

  test "should show nomtran" do
    get :show, id: @nomtran
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nomtran
    assert_response :success
  end

  test "should update nomtran" do
    patch :update, id: @nomtran, nomtran: { amount: @nomtran.amount, date: @nomtran.date, nominal_id: @nomtran.nominal_id, tran_id: @nomtran.tran_id, type: @nomtran.type }
    assert_redirected_to nomtran_path(assigns(:nomtran))
  end

  test "should destroy nomtran" do
    assert_difference('Nomtran.count', -1) do
      delete :destroy, id: @nomtran
    end

    assert_redirected_to nomtrans_path
  end
end
