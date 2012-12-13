require 'test_helper'

class SigmasControllerTest < ActionController::TestCase
  setup do
    @sigma = sigmas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sigmas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sigma" do
    assert_difference('Sigma.count') do
      post :create, sigma: { dateTime: @sigma.dateTime, testCode: @sigma.testCode }
    end

    assert_redirected_to sigma_path(assigns(:sigma))
  end

  test "should show sigma" do
    get :show, id: @sigma
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sigma
    assert_response :success
  end

  test "should update sigma" do
    put :update, id: @sigma, sigma: { dateTime: @sigma.dateTime, testCode: @sigma.testCode }
    assert_redirected_to sigma_path(assigns(:sigma))
  end

  test "should destroy sigma" do
    assert_difference('Sigma.count', -1) do
      delete :destroy, id: @sigma
    end

    assert_redirected_to sigmas_path
  end
end
