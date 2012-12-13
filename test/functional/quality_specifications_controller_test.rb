require 'test_helper'

class QualitySpecificationsControllerTest < ActionController::TestCase
  setup do
    @quality_specification = quality_specifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quality_specifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quality_specification" do
    assert_difference('QualitySpecification.count') do
      post :create, quality_specification: { bias: @quality_specification.bias, imprecision: @quality_specification.imprecision, testCode: @quality_specification.testCode }
    end

    assert_redirected_to quality_specification_path(assigns(:quality_specification))
  end

  test "should show quality_specification" do
    get :show, id: @quality_specification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quality_specification
    assert_response :success
  end

  test "should update quality_specification" do
    put :update, id: @quality_specification, quality_specification: { bias: @quality_specification.bias, imprecision: @quality_specification.imprecision, testCode: @quality_specification.testCode }
    assert_redirected_to quality_specification_path(assigns(:quality_specification))
  end

  test "should destroy quality_specification" do
    assert_difference('QualitySpecification.count', -1) do
      delete :destroy, id: @quality_specification
    end

    assert_redirected_to quality_specifications_path
  end
end
