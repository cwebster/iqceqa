require 'test_helper'

class ChangeLoggingsControllerTest < ActionController::TestCase
  setup do
    @change_logging = change_loggings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:change_loggings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create change_logging" do
    assert_difference('ChangeLogging.count') do
      post :create, change_logging: { dateTime: @change_logging.dateTime, logRecord: @change_logging.logRecord }
    end

    assert_redirected_to change_logging_path(assigns(:change_logging))
  end

  test "should show change_logging" do
    get :show, id: @change_logging
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @change_logging
    assert_response :success
  end

  test "should update change_logging" do
    put :update, id: @change_logging, change_logging: { dateTime: @change_logging.dateTime, logRecord: @change_logging.logRecord }
    assert_redirected_to change_logging_path(assigns(:change_logging))
  end

  test "should destroy change_logging" do
    assert_difference('ChangeLogging.count', -1) do
      delete :destroy, id: @change_logging
    end

    assert_redirected_to change_loggings_path
  end
end
