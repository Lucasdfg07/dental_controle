require 'test_helper'

class SpentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spent = spents(:one)
  end

  test "should get index" do
    get spents_url
    assert_response :success
  end

  test "should get new" do
    get new_spent_url
    assert_response :success
  end

  test "should create spent" do
    assert_difference('Spent.count') do
      post spents_url, params: { spent: { description: @spent.description, value: @spent.value } }
    end

    assert_redirected_to spent_url(Spent.last)
  end

  test "should show spent" do
    get spent_url(@spent)
    assert_response :success
  end

  test "should get edit" do
    get edit_spent_url(@spent)
    assert_response :success
  end

  test "should update spent" do
    patch spent_url(@spent), params: { spent: { description: @spent.description, value: @spent.value } }
    assert_redirected_to spent_url(@spent)
  end

  test "should destroy spent" do
    assert_difference('Spent.count', -1) do
      delete spent_url(@spent)
    end

    assert_redirected_to spents_url
  end
end
