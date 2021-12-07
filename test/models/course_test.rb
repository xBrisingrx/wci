# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  start_date      :date
#  finish_date     :date
#  start_hour      :time
#  finish_hour     :time
#  place           :string
#  course_level_id :integer
#  course_type_id  :integer
#  teacher_id      :integer
#  program_id      :integer
#  comment         :text
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
