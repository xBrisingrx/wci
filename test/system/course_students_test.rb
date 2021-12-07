require "application_system_test_case"

class CourseStudentsTest < ApplicationSystemTestCase
  setup do
    @course_student = course_students(:one)
  end

  test "visiting the index" do
    visit course_students_url
    assert_selector "h1", text: "Course Students"
  end

  test "creating a Course student" do
    visit course_students_url
    click_on "New Course Student"

    fill_in "Course", with: @course_student.course_id
    fill_in "Student", with: @course_student.student_id
    click_on "Create Course student"

    assert_text "Course student was successfully created"
    click_on "Back"
  end

  test "updating a Course student" do
    visit course_students_url
    click_on "Edit", match: :first

    fill_in "Course", with: @course_student.course_id
    fill_in "Student", with: @course_student.student_id
    click_on "Update Course student"

    assert_text "Course student was successfully updated"
    click_on "Back"
  end

  test "destroying a Course student" do
    visit course_students_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course student was successfully destroyed"
  end
end
