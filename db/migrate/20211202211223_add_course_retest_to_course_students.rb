class AddCourseRetestToCourseStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :course_students, :remedial_course, :bigint, null:true
    add_foreign_key :course_students, :courses , column: :remedial_course
  end
end
