require "test_helper"

class GymClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gym_class = gym_classes(:one)
  end

  test "should get index" do
    get gym_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_gym_class_url
    assert_response :success
  end

  test "should create gym_class" do
    assert_difference("GymClass.count") do
      post gym_classes_url, params: { gym_class: { name: @gym_class.name, schedule: @gym_class.schedule, trainer_id: @gym_class.trainer_id } }
    end

    assert_redirected_to gym_class_url(GymClass.last)
  end

  test "should show gym_class" do
    get gym_class_url(@gym_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_gym_class_url(@gym_class)
    assert_response :success
  end

  test "should update gym_class" do
    patch gym_class_url(@gym_class), params: { gym_class: { name: @gym_class.name, schedule: @gym_class.schedule, trainer_id: @gym_class.trainer_id } }
    assert_redirected_to gym_class_url(@gym_class)
  end

  test "should destroy gym_class" do
    assert_difference("GymClass.count", -1) do
      delete gym_class_url(@gym_class)
    end

    assert_redirected_to gym_classes_url
  end
end
