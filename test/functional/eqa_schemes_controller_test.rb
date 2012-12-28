require 'test_helper'

class EqaSchemesControllerTest < ActionController::TestCase
  setup do
    @eqa_scheme = eqa_schemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eqa_schemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eqa_scheme" do
    assert_difference('EqaScheme.count') do
      post :create, eqa_scheme: { address: @eqa_scheme.address, contact: @eqa_scheme.contact, name: @eqa_scheme.name, website: @eqa_scheme.website }
    end

    assert_redirected_to eqa_scheme_path(assigns(:eqa_scheme))
  end

  test "should show eqa_scheme" do
    get :show, id: @eqa_scheme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eqa_scheme
    assert_response :success
  end

  test "should update eqa_scheme" do
    put :update, id: @eqa_scheme, eqa_scheme: { address: @eqa_scheme.address, contact: @eqa_scheme.contact, name: @eqa_scheme.name, website: @eqa_scheme.website }
    assert_redirected_to eqa_scheme_path(assigns(:eqa_scheme))
  end

  test "should destroy eqa_scheme" do
    assert_difference('EqaScheme.count', -1) do
      delete :destroy, id: @eqa_scheme
    end

    assert_redirected_to eqa_schemes_path
  end
end
