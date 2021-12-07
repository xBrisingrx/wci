require 'test_helper'

class CourseLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_level = course_levels(:one)
  end

  test "should get index" do
    get course_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_course_level_url
    assert_response :success
  end

  test "should create course_level" do
    assert_difference('CourseLevel.count') do
      post course_levels_url, params: { course_level: { name: @course_level.name } }
    end

    assert_redirected_to course_level_url(CourseLevel.last)
  end

  test "should show course_level" do
    get course_level_url(@course_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_level_url(@course_level)
    assert_response :success
  end

  test "should update course_level" do
    patch course_level_url(@course_level), params: { course_level: { name: @course_level.name } }
    assert_redirected_to course_level_url(@course_level)
  end

  test "should destroy course_level" do
    assert_difference('CourseLevel.count', -1) do
      delete course_level_url(@course_level)
    end

    assert_redirected_to course_levels_url
  end
end
