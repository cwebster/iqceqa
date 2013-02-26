require 'test_helper'

class CreateAnalyserTypesControllerTest < ActionController::TestCase
  setup do
    @create_analyser_type = create_analyser_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:create_analyser_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create create_analyser_type" do
    assert_difference('CreateAnalyserType.count') do
      post :create, create_analyser_type: {  }
    end

    assert_redirected_to create_analyser_type_path(assigns(:create_analyser_type))
  end

  test "should show create_analyser_type" do
    get :show, id: @create_analyser_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @create_analyser_type
    assert_response :success
  end

  test "should update create_analyser_type" do
    put :update, id: @create_analyser_type, create_analyser_type: {  }
    assert_redirected_to create_analyser_type_path(assigns(:create_analyser_type))
  end

  test "should destroy create_analyser_type" do
    assert_difference('CreateAnalyserType.count', -1) do
      delete :destroy, id: @create_analyser_type
    end

    assert_redirected_to create_analyser_types_path
  end
end
