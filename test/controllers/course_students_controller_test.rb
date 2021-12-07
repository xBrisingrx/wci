require 'test_helper'

class CourseStudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_student = course_students(:one)
  end

  test "should get index" do
    get course_students_url
    assert_response :success
  end

  test "should get new" do
    get new_course_student_url
    assert_response :success
  end

  test "should create course_student" do
    assert_difference('CourseStudent.count') do
      post course_students_url, params: { course_student: { course_id: @course_student.course_id, student_id: @course_student.student_id } }
    end

    assert_redirected_to course_student_url(CourseStudent.last)
  end

  test "should show course_student" do
    get course_student_url(@course_student)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_student_url(@course_student)
    assert_response :success
  end

  test "should update course_student" do
    patch course_student_url(@course_student), params: { course_student: { course_id: @course_student.course_id, student_id: @course_student.student_id } }
    assert_redirected_to course_student_url(@course_student)
  end

  test "should destroy course_student" do
    assert_difference('CourseStudent.count', -1) do
      delete course_student_url(@course_student)
    end

    assert_redirected_to course_students_url
  end
end
