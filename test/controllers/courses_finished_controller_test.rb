require 'test_helper'

class CoursesFinishedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get courses_finished_index_url
    assert_response :success
  end

end
