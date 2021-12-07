# == Schema Information
#
# Table name: course_types
#
#  id         :integer          not null, primary key
#  name       :string
#  comment    :text
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CourseTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
