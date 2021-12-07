# == Schema Information
#
# Table name: course_levels
#
#  id         :integer          not null, primary key
#  name       :string
#  comment    :text
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CourseLevelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
