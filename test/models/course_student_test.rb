# == Schema Information
#
# Table name: course_students
#
#  id                        :integer          not null, primary key
#  simulation_grade          :integer          default(0)
#  simulation_grade_date     :date
#  simulation_bh_grade       :integer          default(0)
#  simulation_bh_grade_date  :date
#  simulation_inv_grade      :integer          default(0)
#  simulation_inv_grade_date :date
#  final_grade               :integer          default(0)
#  final_grade_date          :date
#  remedial_exam_note        :integer          default(0)
#  remedial_exam_note_date   :date
#  status                    :integer          default("pending")
#  comment                   :text
#  active                    :boolean          default(TRUE)
#  student_id                :integer
#  course_id                 :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
require 'test_helper'

class CourseStudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
