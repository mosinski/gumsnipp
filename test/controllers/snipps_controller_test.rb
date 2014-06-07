require 'test_helper'

class SnippsControllerTest < ActionController::TestCase
  setup do
    @snipp = snipps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snipps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snipp" do
    assert_difference('Snipp.count') do
      post :create, snipp: { css_code: @snipp.css_code, html_code: @snipp.html_code, js_code: @snipp.js_code, title: @snipp.title, user_id: @snipp.user_id }
    end

    assert_redirected_to snipp_path(assigns(:snipp))
  end

  test "should show snipp" do
    get :show, id: @snipp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snipp
    assert_response :success
  end

  test "should update snipp" do
    patch :update, id: @snipp, snipp: { css_code: @snipp.css_code, html_code: @snipp.html_code, js_code: @snipp.js_code, title: @snipp.title, user_id: @snipp.user_id }
    assert_redirected_to snipp_path(assigns(:snipp))
  end

  test "should destroy snipp" do
    assert_difference('Snipp.count', -1) do
      delete :destroy, id: @snipp
    end

    assert_redirected_to snipps_path
  end
end
