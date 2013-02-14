require 'test_helper'

class FormBuildersControllerTest < ActionController::TestCase
  setup do
    @form_builder = form_builders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:form_builders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create form_builder" do
    assert_difference('FormBuilder.count') do
      post :create, form_builder: {  }
    end

    assert_redirected_to form_builder_path(assigns(:form_builder))
  end

  test "should show form_builder" do
    get :show, id: @form_builder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @form_builder
    assert_response :success
  end

  test "should update form_builder" do
    put :update, id: @form_builder, form_builder: {  }
    assert_redirected_to form_builder_path(assigns(:form_builder))
  end

  test "should destroy form_builder" do
    assert_difference('FormBuilder.count', -1) do
      delete :destroy, id: @form_builder
    end

    assert_redirected_to form_builders_path
  end
end
