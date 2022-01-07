class AddIsRetestToCourseStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :course_students, :is_retest, :boolean, default: 0
    add_column :course_students, :retest_pending, :boolean, default: 1
    rename_column :course_students, :remedial_course, :remedial_course_id
  end
end
