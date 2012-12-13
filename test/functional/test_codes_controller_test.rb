require 'test_helper'

class TestCodesControllerTest < ActionController::TestCase
  setup do
    @test_code = test_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_code" do
    assert_difference('TestCode.count') do
      post :create, test_code: {  }
    end

    assert_redirected_to test_code_path(assigns(:test_code))
  end

  test "should show test_code" do
    get :show, id: @test_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_code
    assert_response :success
  end

  test "should update test_code" do
    put :update, id: @test_code, test_code: {  }
    assert_redirected_to test_code_path(assigns(:test_code))
  end

  test "should destroy test_code" do
    assert_difference('TestCode.count', -1) do
      delete :destroy, id: @test_code
    end

    assert_redirected_to test_codes_path
  end
end
