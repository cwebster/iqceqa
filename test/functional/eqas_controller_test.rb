require 'test_helper'

class EqasControllerTest < ActionController::TestCase
  setup do
    @eqa = eqas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eqas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eqa" do
    assert_difference('Eqa.count') do
      post :create, eqa: { bias: @eqa.bias, dateTime: @eqa.dateTime, notes: @eqa.notes, scheme: @eqa.scheme, testCode: @eqa.testCode }
    end

    assert_redirected_to eqa_path(assigns(:eqa))
  end

  test "should show eqa" do
    get :show, id: @eqa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eqa
    assert_response :success
  end

  test "should update eqa" do
    put :update, id: @eqa, eqa: { bias: @eqa.bias, dateTime: @eqa.dateTime, notes: @eqa.notes, scheme: @eqa.scheme, testCode: @eqa.testCode }
    assert_redirected_to eqa_path(assigns(:eqa))
  end

  test "should destroy eqa" do
    assert_difference('Eqa.count', -1) do
      delete :destroy, id: @eqa
    end

    assert_redirected_to eqas_path
  end
end
