require 'test_helper'

class IqcDataControllerTest < ActionController::TestCase
  setup do
    @iqc_datum = iqc_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:iqc_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create iqc_datum" do
    assert_difference('IqcDatum.count') do
      post :create, iqc_datum: { dataID: @iqc_datum.dataID, dateTime: @iqc_datum.dateTime, notes: @iqc_datum.notes, result: @iqc_datum.result, testCode: @iqc_datum.testCode }
    end

    assert_redirected_to iqc_datum_path(assigns(:iqc_datum))
  end

  test "should show iqc_datum" do
    get :show, id: @iqc_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @iqc_datum
    assert_response :success
  end

  test "should update iqc_datum" do
    put :update, id: @iqc_datum, iqc_datum: { dataID: @iqc_datum.dataID, dateTime: @iqc_datum.dateTime, notes: @iqc_datum.notes, result: @iqc_datum.result, testCode: @iqc_datum.testCode }
    assert_redirected_to iqc_datum_path(assigns(:iqc_datum))
  end

  test "should destroy iqc_datum" do
    assert_difference('IqcDatum.count', -1) do
      delete :destroy, id: @iqc_datum
    end

    assert_redirected_to iqc_data_path
  end
end
