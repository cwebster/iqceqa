require 'test_helper'

class AnalyserClassesControllerTest < ActionController::TestCase
  setup do
    @analyser_class = analyser_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analyser_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analyser_class" do
    assert_difference('AnalyserClass.count') do
      post :create, analyser_class: { class_type: @analyser_class.class_type }
    end

    assert_redirected_to analyser_class_path(assigns(:analyser_class))
  end

  test "should show analyser_class" do
    get :show, id: @analyser_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analyser_class
    assert_response :success
  end

  test "should update analyser_class" do
    put :update, id: @analyser_class, analyser_class: { class_type: @analyser_class.class_type }
    assert_redirected_to analyser_class_path(assigns(:analyser_class))
  end

  test "should destroy analyser_class" do
    assert_difference('AnalyserClass.count', -1) do
      delete :destroy, id: @analyser_class
    end

    assert_redirected_to analyser_classes_path
  end
end
