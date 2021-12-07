require "application_system_test_case"

class CourseLevelsTest < ApplicationSystemTestCase
  setup do
    @course_level = course_levels(:one)
  end

  test "visiting the index" do
    visit course_levels_url
    assert_selector "h1", text: "Course Levels"
  end

  test "creating a Course level" do
    visit course_levels_url
    click_on "New Course Level"

    fill_in "Name", with: @course_level.name
    click_on "Create Course level"

    assert_text "Course level was successfully created"
    click_on "Back"
  end

  test "updating a Course level" do
    visit course_levels_url
    click_on "Edit", match: :first

    fill_in "Name", with: @course_level.name
    click_on "Update Course level"

    assert_text "Course level was successfully updated"
    click_on "Back"
  end

  test "destroying a Course level" do
    visit course_levels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course level was successfully destroyed"
  end
end
