require "application_system_test_case"

class CourseTypesTest < ApplicationSystemTestCase
  setup do
    @course_type = course_types(:one)
  end

  test "visiting the index" do
    visit course_types_url
    assert_selector "h1", text: "Course Types"
  end

  test "creating a Course type" do
    visit course_types_url
    click_on "New Course Type"

    check "Active" if @course_type.active
    fill_in "Name", with: @course_type.name
    click_on "Create Course type"

    assert_text "Course type was successfully created"
    click_on "Back"
  end

  test "updating a Course type" do
    visit course_types_url
    click_on "Edit", match: :first

    check "Active" if @course_type.active
    fill_in "Name", with: @course_type.name
    click_on "Update Course type"

    assert_text "Course type was successfully updated"
    click_on "Back"
  end

  test "destroying a Course type" do
    visit course_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course type was successfully destroyed"
  end
end
