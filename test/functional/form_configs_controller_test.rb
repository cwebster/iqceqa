require 'test_helper'

class FormConfigsControllerTest < ActionController::TestCase
  setup do
    @form_config = form_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:form_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create form_config" do
    assert_difference('FormConfig.count') do
      post :create, form_config: {  }
    end

    assert_redirected_to form_config_path(assigns(:form_config))
  end

  test "should show form_config" do
    get :show, id: @form_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @form_config
    assert_response :success
  end

  test "should update form_config" do
    put :update, id: @form_config, form_config: {  }
    assert_redirected_to form_config_path(assigns(:form_config))
  end

  test "should destroy form_config" do
    assert_difference('FormConfig.count', -1) do
      delete :destroy, id: @form_config
    end

    assert_redirected_to form_configs_path
  end
end
