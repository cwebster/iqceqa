require 'test_helper'

class AnalyserTypesControllerTest < ActionController::TestCase
  setup do
    @analyser_type = analyser_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analyser_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analyser_type" do
    assert_difference('AnalyserType.count') do
      post :create, analyser_type: {  }
    end

    assert_redirected_to analyser_type_path(assigns(:analyser_type))
  end

  test "should show analyser_type" do
    get :show, id: @analyser_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analyser_type
    assert_response :success
  end

  test "should update analyser_type" do
    put :update, id: @analyser_type, analyser_type: {  }
    assert_redirected_to analyser_type_path(assigns(:analyser_type))
  end

  test "should destroy analyser_type" do
    assert_difference('AnalyserType.count', -1) do
      delete :destroy, id: @analyser_type
    end

    assert_redirected_to analyser_types_path
  end
end
